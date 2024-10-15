'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "cd5dec1ab26463639a9230a16c9ab3be",
"version.json": "6d83db69bddc8f7c51bb036303b03b06",
"index.html": "e6624fb782046ca48ee01543881a73c3",
"/": "e6624fb782046ca48ee01543881a73c3",
"main.dart.js": "895097cd608fe8966438fcad76859389",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "4e994e8855a48c2ed58b7d650ae3f2ae",
"assets/AssetManifest.json": "289989c5a2ed44cc6249eede3b4bca2b",
"assets/NOTICES": "1fca2a72579d66a902d267fad9ef9187",
"assets/FontManifest.json": "aaa7a0121a1632062f8b34127c270319",
"assets/AssetManifest.bin.json": "c09b0ae76fd00312c3f8531a086bd91b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "391ff5f9f24097f4f6e4406690a06243",
"assets/packages/wechat_assets_picker/assets/icon/indicator-live-photos.png": "a96d2373c82eb49440e29d2fcbd21d37",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/camerawesome/assets/icons/1_1.png": "9fccda0fa73f4e7870fc9db46a61b8f5",
"assets/packages/camerawesome/assets/icons/16_9.png": "ee01c5857314518ac7f3e31d891ae436",
"assets/packages/camerawesome/assets/icons/4_3.png": "0091aca9a18eb33b968ec3abf62699a3",
"assets/packages/camerawesome/assets/icons/minimized.png": "1589a3aefe13c85c8bf2296863881c3d",
"assets/packages/camerawesome/assets/icons/expanded.png": "b8bce8882199b9e134b7b2d102317d3a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "5f22a8c47d8139f462d14a1ff3333609",
"assets/fonts/iconfont.ttf": "6d1c4b4aa22e1d95d7438d5bd3b75213",
"assets/fonts/MaterialIcons-Regular.otf": "cbc0bfea66ec90429c55d67eea4eeda8",
"assets/assets/svg/common_expand_back.svg": "03daef6746c7f9b12ce892075e5a852e",
"assets/assets/svg/my_close.svg": "9f8af0fb271f89770ca18b5f61210a69",
"assets/assets/svg/refresh.svg": "239c7377c25c29674ee349a8ddac3db2",
"assets/assets/svg/wechat.svg": "d4b6b47e88fa55b892184515b0d5c06f",
"assets/assets/svg/my_setting.svg": "27568d3f080e1432c08291f403688386",
"assets/assets/svg/qq.svg": "768571183b35fc79712db22b8502e719",
"assets/assets/svg/pause.svg": "eecdfc2064900cdf25ba397e0d94130e",
"assets/assets/comments/video_id_1.json": "b0d2f8d3abab274eb69c2181e0306ddd",
"assets/assets/images/2.0x/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/2.0x/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/2.0x/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/2.0x/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/2.0x/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
"assets/assets/images/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/3.0x/guide.jpg": "08f8d8298748f2aae4f8314bc3eb2cc0",
"assets/assets/images/3.0x/msg-icon7.webp": "3637c3a7c1788a951ef50e64c5acae6a",
"assets/assets/images/3.0x/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/3.0x/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/3.0x/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
"assets/assets/images/msg-icon6.webp": "4ed1d6a1675c991da82d7946a5abcead",
"assets/assets/images/msg-icon9.webp": "74289573d242ff586759b4b7254a7c72",
"assets/assets/images/msg-icon8.webp": "9d1530e9b0e7828e8b5935feadbb6c7a",
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
