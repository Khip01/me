'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"site.webmanifest": "a9846ff2ab8658a079410e7f00864940",
"manifest.json": "c4ba46dc44243c15d8608d8214d3fe8b",
"favicon-16x16.png": "3807d1ab0824f5ea43536edb57bfca49",
"version.json": "cb0239f6211614b671ba2a6b4e1e780f",
"apple-touch-icon.png": "397cf701855fee907de536f14eef621a",
"android-chrome-48x48.png": "357316c5c8d625bf5f95e39a3ba8cf65",
"mstile-150x150.png": "06f809268e5597b85054fab810990e67",
"icons/Icon-512.png": "6d32843072490bc6ee4ff0e1c24cf76e",
"icons/Icon-maskable-512.png": "edae6bf6e65bd6a49e27eedb7a528a0f",
"icons/Icon-192.png": "cb9887be9a24f48787c837ffb4dd41a2",
"icons/Icon-maskable-192.png": "2d91e1a5a3f9e13ae381b358c0f33993",
"browserconfig.xml": "a493ba0aa0b8ec8068d786d7248bb92c",
"main.dart.js": "282ba50030932eb80d2c5bae83c54b2c",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"safari-pinned-tab.svg": "5910c3c326ee327916d389c1ee3758d6",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon-32x32.png": "26e2e9dd3f46b5d552fb296009591c01",
"favicon.png": "3807d1ab0824f5ea43536edb57bfca49",
"assets/AssetManifest.bin.json": "d2c8effb23e3c74471db4ff7643e97da",
"assets/AssetManifest.bin": "b02cd484e8891f66b13151a5e02b8873",
"assets/FontManifest.json": "f09794c75d8212f5a0148a5f7173f27d",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "728e0c8760085224ca0b46237c240cba",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/NOTICES": "7afe03a75833021bd090ce5c68e2bde6",
"assets/assets/lato_fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/lato_fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/lato_fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/lato_fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/lato_fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/lato_fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/lato_fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/lato_fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/lato_fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/lato_fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/icons/flutter_16.webp": "645b55e523715abfa57668f5c0496eb7",
"assets/assets/icons/browser/browser_dark.webp": "3d83e8221b752e17a7ef5957e04513b9",
"assets/assets/icons/browser/browser_light.webp": "876f0d2b7dc9b8a37327472426528c5e",
"assets/assets/icons/linkedin/linkedin_hover_light.webp": "370e20badb83f0adbacd91784f34f6a2",
"assets/assets/icons/linkedin/linkedin_hover_dark.webp": "19ec93b2792cf90db84c9a128bb025f4",
"assets/assets/icons/linkedin/linkedin_default.webp": "02355306bd3d9c34c29d5a86409d0f2b",
"assets/assets/icons/github/github_hover_dark.webp": "d6cb8e4c9a7613a26be49f17a0455ca3",
"assets/assets/icons/github/github_default.webp": "d2d973211f3dbceffa57cb66e9385fb3",
"assets/assets/icons/github/github_hover_light.webp": "cc156dddb8ea56bbfea3650e07cee80f",
"assets/assets/icons/instagram/instagram_hover_light.webp": "3c804bfd99fabd433a39d4a2575d9a7b",
"assets/assets/icons/instagram/instagram_hover_dark.webp": "ffb34f73c088a59727e28f652f84cdf6",
"assets/assets/icons/instagram/instagram_default.webp": "e924d2740721720b16041ddbaf652ee7",
"assets/assets/icons/firebasenew16.webp": "a3bdddec04762bfa2fa6e64eaf3062f8",
"assets/assets/icons/waving_hand.webp": "fbb6e1fe3a4b99953391663951551f46",
"assets/assets/icons/facebook/facebook_default.webp": "6f216d0b5754581e9f4ced6fb07a7df6",
"assets/assets/icons/facebook/facebook_hover_dark.webp": "7973cd69c005255f9305bbd4a14b3491",
"assets/assets/icons/facebook/facebook_hover_light.webp": "3e8a26ab819df1858ab504638ce7b0e0",
"assets/assets/icons/gmail/gmail_hover_dark.webp": "3c786b43ce70cef88cc1adfeba151de7",
"assets/assets/icons/gmail/gmail_hover_light.webp": "2c4fac14d841609a6799a1c93cf54f0d",
"assets/assets/icons/gmail/gmail_default.webp": "7a4eb04e8d788cabdcd50ba93ca3a20c",
"assets/assets/icons/firebase16.webp": "0fd5ad3d98f2663a4b8d2ef18fbe49d0",
"assets/assets/icons/link/link_light.webp": "9a3a6f0558b173261cc0f0ed1af31ed6",
"assets/assets/icons/link/link_dark.webp": "30fc9b3d855c52f7586e795f70dc39b3",
"assets/assets/images/creators_photo/khip01_profile.webp": "5adcee0ffd93ab83a96608fd77fb6b7a",
"assets/assets/images/projects/kalkulator_basic_cpp/kalkulator_basic_cpp.webp": "94e95c79d8fd7626e5bf3922801567dd",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_3.webp": "8ce26d68b9c96028453997e5f70ca0a2",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_2.webp": "042b8f2240710a6ed66aeb598d481fff",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_cover.webp": "aa37debef3a59e77599a6af74a96ac43",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_2.webp": "6e583b49cd3fff89fae8d31a73abf85b",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_3.webp": "2f815d62d1dadf659953cc0014e7a9ee",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_cover.webp": "5dd37636af971a2879de7f5fc7569474",
"assets/assets/images/projects/calculator_gui_java/calculator_gui_java_cover.webp": "59dd0f7117cad614b69a322bcb5637b6",
"assets/assets/images/projects/todolist_app/todolist_app_cover.webp": "8a2c3cf6868fc74a562e0fdca2f221a9",
"assets/assets/images/projects/todolist_app/todolist_app_4.webp": "40780083d995b0f931d6f426a075e0ce",
"assets/assets/images/projects/todolist_app/todolist_app_3.webp": "e504bd34602fc2db76e1ce3632ac0f42",
"assets/assets/images/projects/todolist_app/todolist_app_2.webp": "73a95325cd9c3c6c1fcd9d9d1fe521cf",
"assets/assets/images/projects/spppayment_spppay/spppayment_spppay_cover.webp": "03032594cd1be51ef7ecdaf85316880e",
"assets/assets/images/projects/spppayment_spppay/spppayment_spppay_2.webp": "dc5afb759fc817e97e0e19806e47def9",
"assets/assets/images/projects/flutter_portfolio/flutter_portfolio_cover.webp": "2ae50ed159d0efb8634e626e8c34f1be",
"assets/assets/images/projects/comment_section_web/comment_section_web_cover.webp": "a059b8b477103b30afc74f39ac921055",
"assets/assets/images/projects/scanthesis/scanthesis_5.webp": "b6c18d3ed0142a092175a61f355627d7",
"assets/assets/images/projects/scanthesis/scanthesis_3.webp": "3921ef1c7aa84946543427448cb44e4c",
"assets/assets/images/projects/scanthesis/scanthesis_cover.webp": "e8b96adab4178d20258b85c7820489d9",
"assets/assets/images/projects/scanthesis/scanthesis_4.webp": "f7de3702a328bf61b8ff73b5afc6a1a8",
"assets/assets/images/projects/scanthesis/scanthesis_2.webp": "3a40ce537fc7b625ddf15096b4cdffbb",
"assets/assets/images/projects/rock_papper_scissors_game/rock_papper_scissors_game_2.webp": "fb6bda12a2d3418637dbf987f6959765",
"assets/assets/images/projects/rock_papper_scissors_game/rock_papper_scissors_game_cover.webp": "2604e605a8bd9201a2919735ee7abfed",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_3.webp": "0d30b2f1e1c8b3be4a7a84ac4a2e13d6",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_2.webp": "41a5d3e6600947e18b94ceb52fee9137",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_cover.webp": "73bf595b3392a9f9e31d1b21674e76e4",
"assets/assets/images/projects/cafeapp_khipcafe/cafeapp_khipcafe_cover.webp": "53a4a292eab61ec8b9b573a0d185d4e5",
"assets/assets/images/certificates/professional_certification_institute_exam/professional_certification_institute_exam_01.webp": "725180ca59197c7ec2443688c39232cb",
"assets/assets/images/certificates/professional_certification_institute_exam/professional_certification_institute_exam_02.webp": "854239bb80ca091c24214cb59f62cae0",
"assets/assets/images/certificates/competency_test_for_software_engineering_expertise/competency_test_for_software_engineering_expertise_01.webp": "424999674a2eb4b81c41ec89bbb7b310",
"assets/assets/images/certificates/competency_test_for_software_engineering_expertise/competency_test_for_software_engineering_expertise_02.webp": "74598d2ef347c8eead8980c960a8b2e2",
"assets/assets/images/certificates/dicoding_learn_to_make_flutter_apps_for_beginners/dicoding_learn_to_make_flutter_apps_for_beginners_02.webp": "ad309caa019a05779a490777ff26e493",
"assets/assets/images/certificates/dicoding_learn_to_make_flutter_apps_for_beginners/dicoding_learn_to_make_flutter_apps_for_beginners_01.webp": "1da96f048904c0284d70fc467ee9e594",
"assets/assets/images/certificates/test_of_english_for_international_communication/test_of_english_for_international_communication_01.webp": "3ea214da2079fb578cf8d47b99a4e830",
"assets/assets/images/certificates/it_software_solutions_for_business/it_software_solutions_for_business_01.webp": "0f2fdb748830d97e556a6ca92f902957",
"assets/assets/images/certificates/polytechnic_english_competence_test/polytechnic_english_competence_test_02.webp": "83ec0b17c7d3d25178f59e78432c1494",
"assets/assets/images/certificates/polytechnic_english_competence_test/polytechnic_english_competence_test_01.webp": "394fc7d43b5a948af3000e859f381c51",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_02.webp": "8f1d6d5e8927675d50815ae25c1f7155",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_03.webp": "f7bf7ac577e959c69db02f96044eae2d",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_01.webp": "1470829f8ca5f494c4033fc661923d0f",
"favicon.ico": "37d805c70cde765ba36478f63d153599",
"flutter_bootstrap.js": "148bb9da3f944df019ce6b9bf32ceb55",
"index.html": "4ab9a3461c2928e8e20b49b86aba551c",
"/": "4ab9a3461c2928e8e20b49b86aba551c"};
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
