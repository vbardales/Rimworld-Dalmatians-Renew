using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace DalmatiansRenew.PickleSteps
{
    /// <summary>
    /// What a scenario has spawned, by the alias its feature gave it. Pawns are remembered by
    /// thingIDNumber, not by reference: a save and reload replaces every object, and the number is
    /// what the game keeps. The coat of an animal is itself a function of that number.
    /// </summary>
    internal static class Scene
    {
        private static readonly Dictionary<string, int> ids = new Dictionary<string, int>();
        private static readonly List<int> batch = new List<int>();

        internal static readonly Dictionary<string, int> Coats = new Dictionary<string, int>();
        internal static List<string> LastButchered = new List<string>();
        internal static Thing LaidOut;

        internal static void Reset()
        {
            ids.Clear();
            batch.Clear();
            Coats.Clear();
            LaidOut = null;
            LastButchered = new List<string>();
        }

        internal static Map Map(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null,
                "no current map: load the test-colony fixture before this step");
            return Find.CurrentMap;
        }

        internal static void Remember(string alias, Pawn pawn) => ids[alias] = pawn.thingIDNumber;

        internal static void RememberInBatch(Pawn pawn) => batch.Add(pawn.thingIDNumber);

        internal static Pawn Named(PickleContext ctx, string alias)
        {
            int id;
            ctx.Require(ids.TryGetValue(alias, out id), $"no animal was spawned under the alias '{alias}'");
            return Locate(ctx, id, alias);
        }

        internal static List<Pawn> Batch(PickleContext ctx) => batch.Select(id => Locate(ctx, id, "batch")).ToList();

        private static Pawn Locate(PickleContext ctx, int id, string what)
        {
            Map(ctx);
            var pawn = PawnsFinder.AllMapsWorldAndTemporary_AliveOrDead.FirstOrDefault(p => p.thingIDNumber == id);
            ctx.Require(pawn != null, $"the pawn behind '{what}' (thingIDNumber {id}) no longer exists");
            return pawn;
        }
    }
}
