using System;
using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace DalmatiansRenew.PickleSteps
{
    /// <summary>
    /// The two-launch removal chain (scenario K), after Animal Apparel Collars and Kit Renew's scenario H: the
    /// game saved in launch 1 is copied into the Pickle/Fixtures folder of a companion that does not depend on
    /// this mod, where launch 2 finds it as a fixture once this mod has left the mod list.
    /// </summary>
    [PickleSteps]
    public class RemovalSteps
    {
        [When("Dalmatians Renew saves the game as {string}")]
        public void SaveGameAs(PickleContext ctx, string file)
        {
            GameDataSaveLoader.SaveGame(file);
            ctx.Require(System.IO.File.Exists(GenFilePaths.FilePathForSavedGame(file)), $"no save file was written for {file}");
        }

        [When("Dalmatians Renew hands the saved game {string} to the mod {string}")]
        public void HandSavedGameTo(PickleContext ctx, string file, string packageId)
        {
            ModContentPack target = LoadedModManager.RunningModsListForReading.FirstOrDefault(
                m => string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(target != null, $"no active mod has the packageId {packageId}");
            string folder = System.IO.Path.Combine(target.RootDir, "Pickle", "Fixtures");
            System.IO.Directory.CreateDirectory(folder);
            string destination = System.IO.Path.Combine(folder, file + ".rws");
            System.IO.File.Copy(GenFilePaths.FilePathForSavedGame(file), destination, true);
            ctx.Require(System.IO.File.Exists(destination), $"the saved game was not copied to {destination}");
        }
    }
}
