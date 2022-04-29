using HarmonyLib;
using NeosModLoader;
using FrooxEngine;

namespace VideoToStream
{
    public class Patch : NeosMod
    {
        public override string Name => "VideoToStream";
        public override string Author => "LeCloutPanda";
        public override string Version => "1.0.0";
        public override string Link => "https://github.com/LeCloutPanda/VideoToStream";

        [AutoRegisterConfigKey]
        private static ModConfigurationKey<bool> ENABLED = new ModConfigurationKey<bool>("Set Video players to Stream(Only your players)", "", () => true);

        public static ModConfiguration config;

        public override void OnEngineInit()
        {
            config = GetConfiguration();
            config.Save(true);

            Harmony harmony = new Harmony($"{Author}.{Name}");
            harmony.PatchAll();
        }

        [HarmonyPatch(typeof(VideoPlayer), "OnAttach")]
        class VideoPlayerPatch
        {
            static void Prefix(ref VideoPlayer __instance)
            {
                if (!config.GetValue(ENABLED))
                    return;

                __instance.Slot.GetComponent<VideoTextureProvider>().Stream.Value = true;
            }

        }
    }
}
