using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace DalmatiansRenew.PickleSteps
{
    /// <summary>
    /// Reads of the live defs, after every patch of the mod list under test has been applied. The
    /// offline suite reads the same XML before the game touches it; these read what the game kept.
    /// </summary>
    [PickleSteps]
    public class DefSteps
    {
        private static ThingDef Thing(PickleContext ctx, string defName)
        {
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}' is loaded in this pass");
            return def;
        }

        private static PawnKindDef Kind(PickleContext ctx, string defName)
        {
            var def = DefDatabase<PawnKindDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no PawnKindDef named '{defName}' is loaded in this pass");
            return def;
        }

        private static HashSet<string> Operations(PickleContext ctx, string defName) =>
            new HashSet<string>(Thing(ctx, defName).AllRecipes.Select(r => r.defName));

        // ---- operations offered by an animal (A Dog Said... Animal Prosthetics 2) ----

        [Then("Dalmatians Renew {string} offers the same operations as {string}")]
        public void SameOperations(PickleContext ctx, string thing, string other)
        {
            var a = Operations(ctx, thing);
            var b = Operations(ctx, other);
            var missing = b.Except(a).OrderBy(x => x).ToList();
            var extra = a.Except(b).OrderBy(x => x).ToList();
            ctx.Assert(missing.Count == 0 && extra.Count == 0,
                $"{thing} offers {a.Count} operations and {other} {b.Count}; " +
                $"only {other} offers [{string.Join(", ", missing)}]; only {thing} offers [{string.Join(", ", extra)}]");
        }

        [Then("Dalmatians Renew {string} offers more operations than {string}")]
        public void MoreOperations(PickleContext ctx, string thing, string other)
        {
            int a = Operations(ctx, thing).Count, b = Operations(ctx, other).Count;
            ctx.Assert(a > b, $"{thing} offers {a} operations and {other} {b}; expected more for {thing}");
        }

        [Then("Dalmatians Renew {string} offers fewer operations than {string}")]
        public void FewerOperations(PickleContext ctx, string thing, string other)
        {
            int a = Operations(ctx, thing).Count, b = Operations(ctx, other).Count;
            ctx.Assert(a < b, $"{thing} offers {a} operations and {other} {b}; expected fewer for {thing}");
        }

        // ---- trade ----

        [Then("Dalmatians Renew some trader kind stocks {string}")]
        public void SomeTraderStocks(PickleContext ctx, string defName)
        {
            var def = Thing(ctx, defName);
            ctx.Assert(StockingTraders(def).Any(), $"no trader kind's animal stock generator handles {defName}");
        }

        [Then("Dalmatians Renew no trader kind stocks {string}")]
        public void NoTraderStocks(PickleContext ctx, string defName)
        {
            var def = Thing(ctx, defName);
            var found = StockingTraders(def).ToList();
            ctx.Assert(found.Count == 0, $"{defName} is still stocked by [{string.Join(", ", found)}]");
        }

        private static IEnumerable<string> StockingTraders(ThingDef def) =>
            DefDatabase<TraderKindDef>.AllDefs
                .Where(t => t.stockGenerators != null &&
                            t.stockGenerators.OfType<StockGenerator_Animals>().Any(g => g.HandlesThingDef(def)))
                .Select(t => t.defName);

        [Then("Dalmatians Renew the player can sell {string}")]
        public void PlayerCanSell(PickleContext ctx, string defName) =>
            ctx.Assert(TradeUtility.EverPlayerSellable(Thing(ctx, defName)), $"{defName} can never be sold by the player");

        // ---- the race ----

        [Then("Dalmatians Renew the litter size curve of {string} peaks at {int}")]
        public void LitterPeak(PickleContext ctx, string defName, int size)
        {
            var curve = Thing(ctx, defName).race.litterSizeCurve;
            ctx.Require(curve != null && curve.PointsCount > 0, $"{defName} has no litterSizeCurve");
            var peak = curve.Points.OrderByDescending(p => p.y).First();
            ctx.Assert(UnityEngine.Mathf.RoundToInt(peak.x) == size,
                $"the litter size curve of {defName} peaks at {peak.x} (weight {peak.y}), expected {size}");
        }

        // ---- what Pickle's own def steps cannot say ----
        // CCPDalmatian names both a ThingDef and a PawnKindDef, and so does WD_Dalmatian. Pickle's
        // "def X field/is defined by mod/stat" refuses a name that two def types share, and offers no
        // way to say which, so the steps below say it.

        private static bool FromMod(ModContentPack pack, string packageId) =>
            pack != null && (string.Equals(pack.PackageId, packageId, System.StringComparison.OrdinalIgnoreCase) ||
                             string.Equals(pack.PackageIdPlayerFacing, packageId, System.StringComparison.OrdinalIgnoreCase));

        [Then("Dalmatians Renew the thing {string} comes from the mod {string}")]
        public void ThingFromMod(PickleContext ctx, string defName, string packageId)
        {
            var pack = Thing(ctx, defName).modContentPack;
            ctx.Assert(FromMod(pack, packageId), $"the thing {defName} comes from '{pack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        [Then("Dalmatians Renew the pawn kind {string} comes from the mod {string}")]
        public void KindFromMod(PickleContext ctx, string defName, string packageId)
        {
            var pack = Kind(ctx, defName).modContentPack;
            ctx.Assert(FromMod(pack, packageId), $"the pawn kind {defName} comes from '{pack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        [Then("Dalmatians Renew the race of {string} reads {string} as {string}")]
        public void RaceField(PickleContext ctx, string defName, string field, string expected)
        {
            var race = Thing(ctx, defName).race;
            ctx.Require(race != null, $"{defName} has no race");
            var info = typeof(RaceProperties).GetField(field, System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
            ctx.Require(info != null, $"RaceProperties has no public field named '{field}' in this game build");
            var actual = System.Convert.ToString(info.GetValue(race), System.Globalization.CultureInfo.InvariantCulture);
            ctx.Assert(actual == expected, $"the race of {defName} reads {field} as '{actual}', expected '{expected}'");
        }

        [Then("Dalmatians Renew the market value of {string} is {int}")]
        public void MarketValue(PickleContext ctx, string defName, int expected)
        {
            var actual = Thing(ctx, defName).GetStatValueAbstract(StatDefOf.MarketValue);
            ctx.Assert(UnityEngine.Mathf.Approximately(actual, expected), $"{defName} has a market value of {actual}, expected {expected}");
        }

        // The language is chosen when the game starts, never during a run. This asserts the pass, so
        // that one which silently fell back to English cannot pass as French.
        [Then("Dalmatians Renew this pass runs in {word}")]
        public void PassLanguage(PickleContext ctx, string language)
        {
            var actual = LanguageDatabase.activeLanguage?.folderName ?? "(none)";
            ctx.Assert(actual.StartsWith(language, System.StringComparison.OrdinalIgnoreCase),
                $"this pass runs in '{actual}', expected {language}");
        }

        // ---- text, in the language this pass was launched in ----

        [Then("Dalmatians Renew the thing {string} is labelled {string}")]
        public void ThingLabel(PickleContext ctx, string defName, string label) =>
            ctx.Assert(Thing(ctx, defName).label == label, $"{defName} is labelled '{Thing(ctx, defName).label}', expected '{label}'");

        [Then("Dalmatians Renew the thing {string} has a description beginning {string}")]
        public void ThingDescription(PickleContext ctx, string defName, string start)
        {
            var text = Thing(ctx, defName).description ?? "";
            ctx.Assert(text.StartsWith(start), $"{defName} has the description '{text}', expected one beginning '{start}'");
        }

        [Then("Dalmatians Renew the thing {string} has the attack labels {string}")]
        public void AttackLabels(PickleContext ctx, string defName, string expected)
        {
            var tools = Thing(ctx, defName).tools ?? new List<Tool>();
            var actual = string.Join(", ", tools.Where(t => !string.IsNullOrEmpty(t.label)).Select(t => t.label));
            ctx.Assert(actual == expected, $"{defName} has the attack labels '{actual}', expected '{expected}'");
        }

        [Then("Dalmatians Renew the material {string} is called {string} when it names a garment")]
        public void MaterialAdjective(PickleContext ctx, string defName, string expected)
        {
            var def = Thing(ctx, defName);
            var actual = string.IsNullOrEmpty(def.stuffProps?.stuffAdjective) ? def.label : def.stuffProps.stuffAdjective;
            ctx.Assert(actual == expected, $"{defName} is called '{actual}' on a garment, expected '{expected}'");
        }

        [Then("Dalmatians Renew the pawn kind {string} is labelled {string} and pluralised {string}")]
        public void KindLabels(PickleContext ctx, string defName, string label, string plural)
        {
            var kind = Kind(ctx, defName);
            ctx.Assert(kind.label == label && kind.GetLabelPlural() == plural,
                $"{defName} reads '{kind.label}' and '{kind.GetLabelPlural()}', expected '{label}' and '{plural}'");
        }

        [Then("Dalmatians Renew the first life stage of pawn kind {string} is labelled {string} and pluralised {string}")]
        public void PuppyLabels(PickleContext ctx, string defName, string label, string plural)
        {
            var stages = Kind(ctx, defName).lifeStages;
            ctx.Require(stages != null && stages.Count > 0, $"{defName} has no life stages");
            var stage = stages[0];
            ctx.Assert(stage.label == label && stage.labelPlural == plural,
                $"the first stage of {defName} reads '{stage.label}' and '{stage.labelPlural}', expected '{label}' and '{plural}'");
        }
    }
}
