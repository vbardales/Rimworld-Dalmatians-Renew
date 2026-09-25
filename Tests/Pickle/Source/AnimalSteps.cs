using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace DalmatiansRenew.PickleSteps
{
    [PickleSteps]
    public class AnimalSteps
    {
        [BeforeScenario]
        public void ResetScene(PickleContext ctx) => Scene.Reset();

        private static IntVec3 FreeCell(PickleContext ctx, int radius = 20)
        {
            var map = Scene.Map(ctx);
            IntVec3 cell;
            var found = CellFinder.TryFindRandomCellNear(map.Center, map, radius,
                c => c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstPawn(map) == null, out cell);
            ctx.Require(found, $"no free standable cell was found near {map.Center}");
            return cell;
        }

        private static Pawn Spawn(PickleContext ctx, string kindName, Faction faction, float age)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}' is loaded in this pass");
            var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                kind, faction, forceGenerateNewPawn: true, fixedBiologicalAge: age));
            GenSpawn.Spawn(pawn, FreeCell(ctx), Scene.Map(ctx));
            return pawn;
        }

        // The name is left alone on purpose: a wild animal has none, and giving it one here would
        // make the "takes a name the moment it is tamed" scenario pass whatever the race says.
        [Given("Dalmatians Renew spawns the wild animal {string} as {string}")]
        public void SpawnWild(PickleContext ctx, string alias, string kindName) =>
            Scene.Remember(alias, Spawn(ctx, kindName, null, 3f));

        [Given("Dalmatians Renew spawns the player animal {string} as {string}")]
        public void SpawnPlayer(PickleContext ctx, string alias, string kindName) =>
            Scene.Remember(alias, Spawn(ctx, kindName, Faction.OfPlayer, 3f));

        [Given("Dalmatians Renew spawns the player puppy {string} as {string}")]
        public void SpawnPuppy(PickleContext ctx, string alias, string kindName) =>
            Scene.Remember(alias, Spawn(ctx, kindName, Faction.OfPlayer, 0.1f));

        [Given("Dalmatians Renew spawns {int} wild animals as {string}")]
        public void SpawnBatch(PickleContext ctx, int count, string kindName)
        {
            for (var i = 0; i < count; i++) Scene.RememberInBatch(Spawn(ctx, kindName, null, 3f));
        }

        [When("Dalmatians Renew tames {string}")]
        public void Tame(PickleContext ctx, string alias)
        {
            var animal = Scene.Named(ctx, alias);
            var map = Scene.Map(ctx);
            var tamer = map.mapPawns.FreeColonistsSpawned.FirstOrDefault();
            ctx.Require(tamer != null, "the fixture has no free colonist to do the taming");
            ctx.Require(animal.Faction == null, $"{alias} already belongs to {animal.Faction?.Name}");
            InteractionWorker_RecruitAttempt.DoRecruit(tamer, animal);
        }

        [Then("Dalmatians Renew {string} belongs to the player")]
        public void BelongsToPlayer(PickleContext ctx, string alias) =>
            ctx.Assert(Scene.Named(ctx, alias).Faction == Faction.OfPlayer, $"{alias} is not a player animal");

        [Then("Dalmatians Renew {string} has a name")]
        public void HasName(PickleContext ctx, string alias)
        {
            var name = Scene.Named(ctx, alias).Name;
            ctx.Assert(name != null, $"{alias} has no name after being tamed; nameOnTameChance should be 1");
        }

        [Then("Dalmatians Renew {string} has no name")]
        public void HasNoName(PickleContext ctx, string alias)
        {
            var name = Scene.Named(ctx, alias).Name;
            ctx.Assert(name == null, $"{alias} is already named {name}");
        }

        [When("Dalmatians Renew records the coat of {string}")]
        public void RecordCoat(PickleContext ctx, string alias) =>
            Scene.Coats[alias] = Scene.Named(ctx, alias).GetGraphicIndex();

        [Then("Dalmatians Renew the coat of {string} is the one recorded")]
        public void CoatUnchanged(PickleContext ctx, string alias)
        {
            int before;
            ctx.Require(Scene.Coats.TryGetValue(alias, out before), $"no coat was recorded for {alias}");
            var after = Scene.Named(ctx, alias).GetGraphicIndex();
            ctx.Assert(after == before, $"the coat of {alias} was {before} and is now {after}");
        }

        [Then("Dalmatians Renew both coats are drawn, each by at least {int} percent of the spawned batch")]
        public void BothCoats(PickleContext ctx, int percent)
        {
            var pawns = Scene.Batch(ctx);
            ctx.Require(pawns.Count > 0, "no batch was spawned");
            var alternate = pawns.Count(p => p.GetGraphicIndex() >= 0);
            var original = pawns.Count - alternate;
            var floor = pawns.Count * percent / 100;
            ctx.Assert(alternate >= floor && original >= floor,
                $"of {pawns.Count} animals, {original} wear the original coat and {alternate} the alternate one; each should reach {floor}");
        }

        [When("Dalmatians Renew butchers {string}")]
        public void Butcher(PickleContext ctx, string alias)
        {
            var animal = Scene.Named(ctx, alias);
            var butcher = Scene.Map(ctx).mapPawns.FreeColonistsSpawned.FirstOrDefault();
            ctx.Require(butcher != null, "the fixture has no free colonist to butcher with");
            if (!animal.Dead) animal.Kill(null);
            ctx.Require(animal.Corpse != null, $"{alias} left no corpse");
            Scene.LastButchered = animal.Corpse.ButcherProducts(butcher, 1f).Select(t => t.def.defName).ToList();
        }

        [Then("Dalmatians Renew the butchering produced {string}")]
        public void ButcheringProduced(PickleContext ctx, string defName) =>
            ctx.Assert(Scene.LastButchered.Contains(defName),
                $"butchering produced [{string.Join(", ", Scene.LastButchered)}], not {defName}");

        [When("Dalmatians Renew kills {string} and lets the corpse reach {word} rot")]
        public void RotCorpse(PickleContext ctx, string alias, string stage)
        {
            var animal = Scene.Named(ctx, alias);
            if (!animal.Dead) animal.Kill(null);
            var corpse = animal.Corpse;
            ctx.Require(corpse != null, $"{alias} left no corpse");
            var rot = corpse.GetComp<CompRottable>();
            ctx.Require(rot != null, "the corpse has no CompRottable");
            RotStage expected;
            switch (stage)
            {
                case "fresh": rot.RotProgress = 0f; expected = RotStage.Fresh; break;
                case "rotting": rot.RotProgress = rot.PropsRot.TicksToRotStart + 1f; expected = RotStage.Rotting; break;
                case "dessicated": rot.RotProgress = rot.PropsRot.TicksToDessicated + 1f; expected = RotStage.Dessicated; break;
                default: ctx.Require(false, $"'{stage}' is not fresh, rotting or dessicated"); return;
            }
            corpse.InnerPawn.Drawer.renderer.SetAllGraphicsDirty();
            ctx.Assert(corpse.GetRotStage() == expected, $"the corpse is {corpse.GetRotStage()}, expected {expected}");
        }

        // Rotation is set on a paused game: a job would turn the animal again on the next tick.
        [When("Dalmatians Renew shows {string} facing {word}", TimeoutSeconds = 15f)]
        public async Task ShowFacing(PickleContext ctx, string alias, string facing)
        {
            var animal = Scene.Named(ctx, alias);
            Rot4 rot;
            switch (facing)
            {
                case "north": rot = Rot4.North; break;
                case "east": rot = Rot4.East; break;
                case "south": rot = Rot4.South; break;
                case "west": rot = Rot4.West; break;
                default: ctx.Require(false, $"'{facing}' is not north, east, south or west"); return;
            }
            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;
            animal.Rotation = rot;
            await ctx.WaitFrames(3);
            ctx.Assert(animal.Rotation == rot, $"{alias} faces {animal.Rotation}, expected {rot}");
        }

        [When("Dalmatians Renew centres the camera on {string}", TimeoutSeconds = 15f)]
        public async Task CentreCamera(PickleContext ctx, string alias)
        {
            var animal = Scene.Named(ctx, alias);
            var at = animal.Dead && animal.Corpse != null ? animal.Corpse.Position : animal.Position;
            Find.Selector.ClearSelection();
            // Close enough for a person to judge a texture: the first run's captures showed a dog a few
            // pixels wide, because a plain SetRootSize only aims for the size and the camera had not
            // got there after three frames.
            // The position goes through JumpToCurrentMapLoc, which the first run showed to work: setting it
            // with SetRootPosAndSize put the camera at the edge of the map in the second run. Both the size
            // the camera has and the size it aims for are set, since it eases toward the second one.
            Find.CameraDriver.JumpToCurrentMapLoc(at);
            Find.CameraDriver.rootSize = 6f;
            Find.CameraDriver.desiredSize = 6f;
            await ctx.WaitFrames(10);
        }

        [Given("Dalmatians Renew spawns the player animal {string} as {string} beside {string}")]
        public void SpawnBeside(PickleContext ctx, string alias, string kindName, string other)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}' is loaded in this pass");
            var neighbour = Scene.Named(ctx, other);
            var map = Scene.Map(ctx);
            IntVec3 cell;
            var found = CellFinder.TryFindRandomCellNear(neighbour.Position, map, 3,
                c => c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstPawn(map) == null, out cell);
            ctx.Require(found, $"no free standable cell was found beside {other} at {neighbour.Position}");
            var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                kind, Faction.OfPlayer, forceGenerateNewPawn: true, fixedBiologicalAge: 3f));
            GenSpawn.Spawn(pawn, cell, map);
            Scene.Remember(alias, pawn);
        }

        // The coat is a function of thingIDNumber, so the only way to ask for one is to generate
        // until it comes up and throw the others away. At even odds sixty tries all missing has a
        // chance of 2^-60, and Require says so if it ever happens.
        [Given("Dalmatians Renew spawns the player animal {string} as {string} wearing the {word} coat")]
        public void SpawnWithCoat(PickleContext ctx, string alias, string kindName, string coat)
        {
            ctx.Require(coat == "original" || coat == "alternate", $"'{coat}' is not the original or alternate coat");
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}' is loaded in this pass");
            for (var i = 0; i < 60; i++)
            {
                var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                    kind, Faction.OfPlayer, forceGenerateNewPawn: true, fixedBiologicalAge: 3f));
                if ((pawn.GetGraphicIndex() >= 0) == (coat == "alternate"))
                {
                    GenSpawn.Spawn(pawn, FreeCell(ctx), Scene.Map(ctx));
                    Scene.Remember(alias, pawn);
                    return;
                }
                pawn.Discard(true);
            }
            ctx.Require(false, $"sixty {kindName} were generated and none wore the {coat} coat");
        }

        [Given("Dalmatians Renew lays out {string} beside {string}", TimeoutSeconds = 15f)]
        public async Task LayOut(PickleContext ctx, string first, string second)
        {
            var map = Scene.Map(ctx);
            var cell = FreeCell(ctx);
            var a = ThingMaker.MakeThing(DefDatabase<ThingDef>.GetNamed(first));
            var b = ThingMaker.MakeThing(DefDatabase<ThingDef>.GetNamed(second));
            GenSpawn.Spawn(a, cell, map);
            GenSpawn.Spawn(b, cell + IntVec3.East, map);
            Scene.LaidOut = a;
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(cell);
            Find.CameraDriver.SetRootSize(4f);
            await ctx.WaitFrames(3);
        }

        [When("Dalmatians Renew opens the information card of the first thing laid out", TimeoutSeconds = 15f)]
        public async Task OpenLaidOutCard(PickleContext ctx)
        {
            ctx.Require(Scene.LaidOut != null, "nothing was laid out");
            Find.WindowStack.Add(new Dialog_InfoCard(Scene.LaidOut));
            await ctx.WaitFrames(5);
        }

        [When("Dalmatians Renew opens the information card of {string}", TimeoutSeconds = 15f)]
        public async Task OpenCard(PickleContext ctx, string alias)
        {
            Find.WindowStack.Add(new Dialog_InfoCard(Scene.Named(ctx, alias)));
            await ctx.WaitFrames(5);
            ctx.Assert(Find.WindowStack.Windows.OfType<Dialog_InfoCard>().Any(), "the information card did not open");
        }

        // The card lists some forty stats and Wildness sits below the fold, so a capture of the open card
        // does not show the line the scenario is about. The card's own search box narrows it to one.
        [When("Dalmatians Renew filters the open information card to {string}", TimeoutSeconds = 15f)]
        public async Task FilterCard(PickleContext ctx, string text)
        {
            ctx.Require(Find.WindowStack.Windows.OfType<Dialog_InfoCard>().Any(), "no information card is open");
            StatsReportUtility.quickSearchWidget.filter.Text = text;
            // The search box dims the rows that do not match and hides none: the second run showed the
            // top of the list with the box filled in, and the row it found out of view. The Animals
            // category sits near the end, so the list is scrolled down as far as it goes.
            StatsReportUtility.scrollPosition = new Vector2(0f, 100000f);
            await ctx.WaitFrames(10);
        }

        [Then("Dalmatians Renew the information card of {string} lists the stat {string} at {string}")]
        public void CardLists(PickleContext ctx, string alias, string statName, string value)
        {
            var stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            var entry = StatsReportUtility.StatsToDraw(Scene.Named(ctx, alias)).FirstOrDefault(e => e.stat == stat);
            ctx.Assert(entry != null, $"the information card of {alias} does not list {statName}");
            ctx.Assert(entry.ValueString.Trim() == value,
                $"the card lists {statName} at '{entry.ValueString}', expected '{value}'");
        }
    }
}
