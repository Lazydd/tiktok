'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "3579c2502efd1b224a7a78233c6c7c7e",
"version.json": "8a636112d21146170a9ee699b7729139",
"index.html": "4abe7e59e9f1ee59345fc3ae1b77b2e4",
"/": "4abe7e59e9f1ee59345fc3ae1b77b2e4",
"main.dart.js": "0ac4c1f74a99f298077e259eb363cd3f",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "0972c8e32bd87ed831f6ee38e2fb3961",
"assets/AssetManifest.json": "a180852a81d37dd93a516d23e09a4221",
"assets/NOTICES": "37e60cf125ea02259a14a13163b4aa60",
"assets/FontManifest.json": "aaa7a0121a1632062f8b34127c270319",
"assets/AssetManifest.bin.json": "3bd5f3ad0c1942ad947d9006460fb62c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "77a78436ebb7199b462e8f162e3ea1df",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/wechat_assets_picker/assets/icon/indicator-live-photos.png": "a96d2373c82eb49440e29d2fcbd21d37",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_chat_ui/assets/icon-seen.png": "b9d597e29ff2802fd7e74c5086dfb106",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-seen.png": "10c256cc3c194125f8fffa25de5d6b8a",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-attachment.png": "9c8f255d58a0a4b634009e19d4f182fa",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-error.png": "5a59dc97f28a33691ff92d0a128c2b7f",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-arrow.png": "8efbd753127a917b4dc02bf856d32a47",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-send.png": "2a7d5341fd021e6b75842f6dadb623dd",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-document.png": "e61ec1c2da405db33bff22f774fb8307",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-delivered.png": "b6b5d85c3270a5cad19b74651d78c507",
"assets/packages/flutter_chat_ui/assets/icon-attachment.png": "17fc0472816ace725b2411c7e1450cdd",
"assets/packages/flutter_chat_ui/assets/icon-error.png": "4fceef32b6b0fd8782c5298ee463ea56",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-seen.png": "684348b596f7960e59e95cff5475b2f8",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-attachment.png": "fcf6bfd600820e85f90a846af94783f4",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-error.png": "872d7d57b8fff12c1a416867d6c1bc02",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-arrow.png": "3ea423a6ae14f8f6cf1e4c39618d3e4b",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-send.png": "8e7e62d5bc4a0e37e3f953fb8af23d97",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-document.png": "4578cb3d3f316ef952cd2cf52f003df2",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-delivered.png": "28f141c87a74838fc20082e9dea44436",
"assets/packages/flutter_chat_ui/assets/icon-arrow.png": "678ebcc99d8f105210139b30755944d6",
"assets/packages/flutter_chat_ui/assets/icon-send.png": "34e43bc8840ecb609e14d622569cda6a",
"assets/packages/flutter_chat_ui/assets/icon-document.png": "b4477562d9152716c062b6018805d10b",
"assets/packages/flutter_chat_ui/assets/icon-delivered.png": "b064b7cf3e436d196193258848eae910",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/camerawesome/assets/icons/1_1.png": "9fccda0fa73f4e7870fc9db46a61b8f5",
"assets/packages/camerawesome/assets/icons/16_9.png": "ee01c5857314518ac7f3e31d891ae436",
"assets/packages/camerawesome/assets/icons/4_3.png": "0091aca9a18eb33b968ec3abf62699a3",
"assets/packages/camerawesome/assets/icons/minimized.png": "1589a3aefe13c85c8bf2296863881c3d",
"assets/packages/camerawesome/assets/icons/expanded.png": "b8bce8882199b9e134b7b2d102317d3a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9bbef51edb8f714ab65d349562647b3f",
"assets/fonts/iconfont.ttf": "6d1c4b4aa22e1d95d7438d5bd3b75213",
"assets/fonts/MaterialIcons-Regular.otf": "bcc386f2d2eab3b7ad6608b550771e6d",
"assets/assets/svg/search.svg": "829e3f3dde658a3670fafa27c215cfbc",
"assets/assets/svg/deployed_code.svg": "c6e5bdcb0a0b7af8fa14820fee0c7acf",
"assets/assets/svg/common_expand_back.svg": "27b558b138712b0ea2975ad9da6b50d2",
"assets/assets/svg/my_close.svg": "81927da5710775f14b382d8bda3cbae3",
"assets/assets/svg/browser_download.svg": "5b6f4fb37f7dd89f0f69b7676faaa6d1",
"assets/assets/svg/refresh.svg": "95ec33b39b6527ad863ab4f43f9d9acb",
"assets/assets/svg/relocate.svg": "11032b14820203f059a064712d1c28af",
"assets/assets/svg/wechat.svg": "44311a68a548d920b7ba7f0471dad3c4",
"assets/assets/svg/my_setting.svg": "3112a0bce6adb0d60143eb6c6f9f1944",
"assets/assets/svg/qq.svg": "de18c04a5ec9e7bee746c456bc0fd247",
"assets/assets/svg/relocate_fill.svg": "3de72bc7840d24799c63f365291975cd",
"assets/assets/svg/pause.svg": "15db76f0d93660312e19e71bfac2dd79",
"assets/assets/svg/tiktok.svg": "74a4035abd4a4bf4ff206e8a71cb652d",
"assets/assets/comments/video_id_1.json": "b0d2f8d3abab274eb69c2181e0306ddd",
"assets/assets/images/2.0x/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/2.0x/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/2.0x/red_heart.webp": "dae720674a1d80cb280714c2985f84d0",
"assets/assets/images/2.0x/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/2.0x/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/2.0x/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
"assets/assets/images/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/red_heart.webp": "dae720674a1d80cb280714c2985f84d0",
"assets/assets/images/3.0x/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/3.0x/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/3.0x/red_heart.webp": "dae720674a1d80cb280714c2985f84d0",
"assets/assets/images/3.0x/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/3.0x/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/3.0x/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
"assets/assets/images/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
"assets/assets/lotties/liquid_loader.json": "6a80382d1a5f50d06313ae91e4bf7d14",
"assets/assets/videos/videos.json": "ce9a8ce4e5dcc16623a6a14fcc713a09",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
