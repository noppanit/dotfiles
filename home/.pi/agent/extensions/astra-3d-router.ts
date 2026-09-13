import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Auto-switch to GPT-6 Astra for 3D-flavored prompts, and back to the
// default driver once the topic moves on. Quota/error fallback away from
// Astra is handled separately by @cad0p/pi-fallback-provider, which cycles
// through settings.json's enabledModels list.

const ASTRA_PROVIDER = "openai-codex";
const ASTRA_MODEL_ID = "gpt-6-astra";
const FALLBACK_PROVIDER = "openai-codex";
const FALLBACK_MODEL_ID = "gpt-5.6-sol";

const KEYWORDS = [
  "blender",
  "three.js",
  "threejs",
  "webgl",
  "webgpu",
  "opengl",
  "vulkan",
  "shader",
  "glsl",
  "hlsl",
  "mesh",
  "gltf",
  ".glb",
  ".fbx",
  ".obj file",
  "vertex shader",
  "fragment shader",
  "ray tracing",
  "raytracing",
  "unity3d",
  "unreal engine",
  "usd file",
  "point cloud",
  "voxel",
  "3d model",
  "3d scene",
  "3d render",
  "rigging",
  "skeletal animation",
  "uv unwrap",
  "normal map",
  "texture map",
  "collada",
];

function mentions3D(text: string): boolean {
  const lower = text.toLowerCase();
  return KEYWORDS.some((keyword) => lower.includes(keyword));
}

export default function (pi: ExtensionAPI) {
  let switchedByExtension = false;

  pi.on("input", async (event, ctx) => {
    if (event.source !== "interactive" && event.source !== "rpc") {
      return { action: "continue" };
    }

    const is3D = mentions3D(event.text);
    const current = ctx.model;
    const isAstra =
      current?.provider === ASTRA_PROVIDER && current?.id === ASTRA_MODEL_ID;

    if (is3D && !isAstra) {
      const model = ctx.modelRegistry.find(ASTRA_PROVIDER, ASTRA_MODEL_ID);
      if (model) {
        const ok = await pi.setModel(model);
        if (ok) {
          switchedByExtension = true;
          ctx.ui.notify("3D prompt detected — switched to GPT-6 Astra", "info");
        } else {
          ctx.ui.notify("Astra not available (check /login codex)", "warning");
        }
      }
    } else if (!is3D && isAstra && switchedByExtension) {
      const model = ctx.modelRegistry.find(FALLBACK_PROVIDER, FALLBACK_MODEL_ID);
      if (model) {
        const ok = await pi.setModel(model);
        if (ok) {
          switchedByExtension = false;
          ctx.ui.notify("Back to GPT-5.6 Sol", "info");
        }
      }
    }

    return { action: "continue" };
  });
}
