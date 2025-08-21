'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"android-chrome-48x48.png": "357316c5c8d625bf5f95e39a3ba8cf65",
"apple-touch-icon.png": "397cf701855fee907de536f14eef621a",
"assets/AssetManifest.bin": "5d9cac823952776efe8aaa76ac556c18",
"assets/AssetManifest.bin.json": "ecce9e27c778086a9c93671e51e76d39",
"assets/AssetManifest.json": "bc0d3b7bc97f5c185f08e148ced8757e",
"assets/assets/data/khip01-portfolio-default-rtdb-export.json": "4877f77e53ab8200ad11ce0013c449cb",
"assets/assets/icons/browser/browser_dark.png": "417e790b5322f022456deb33dc511886",
"assets/assets/icons/browser/browser_light.png": "9292c2dac93addcd6e2f2646b780c51a",
"assets/assets/icons/facebook/facebook_default.png": "5d25e405048b58db0bc435423f08bd6f",
"assets/assets/icons/facebook/facebook_hover_dark.png": "6181459fc7dd95965afcb9222816c987",
"assets/assets/icons/facebook/facebook_hover_light.png": "60e3e4bc29fbcb5fb964547ebe9c93c2",
"assets/assets/icons/firebase16.png": "9dd79d347a3a8865b890dd3495b58606",
"assets/assets/icons/firebasenew16.png": "2485c8b0c20e8f7d8439237d2b54d6c3",
"assets/assets/icons/flutter_16.png": "848eecf0366cadf7bb143784fd947999",
"assets/assets/icons/github/github_default.png": "b7c56eef344a287a4214d830d315d685",
"assets/assets/icons/github/github_hover_dark.png": "f23c0891ffb1eac38f00acb4846eadb2",
"assets/assets/icons/github/github_hover_light.png": "fa08a8e3d8432f1c369c4e43b4332e55",
"assets/assets/icons/gmail/gmail_default.png": "053189c7feeb0dfc6a838871670f2af4",
"assets/assets/icons/gmail/gmail_hover_dark.png": "4dc9071ebbb23e4db14b92e078af8065",
"assets/assets/icons/gmail/gmail_hover_light.png": "4e8910a60694226df74210aaf618caeb",
"assets/assets/icons/iconcognito_mask.png": "a3eec2b280c0f3ee1e8947d001bea438",
"assets/assets/icons/incognito_fingerprint.png": "8ba1e2c4ed484a8951d48c5fbf9f79ff",
"assets/assets/icons/incognito_mode.png": "50a698a0ee2d960f317df07241c5ce77",
"assets/assets/icons/instagram/instagram_default.png": "34ad5cc7fea9b832d67db57320d5613d",
"assets/assets/icons/instagram/instagram_hover_dark.png": "698901d5a738a7cbc3d9ee206af2549b",
"assets/assets/icons/instagram/instagram_hover_light.png": "c4239736a4239ef309459809b6c8ed73",
"assets/assets/icons/link/link_dark.png": "599f943edc0b0abd7a127c934ccc3f5f",
"assets/assets/icons/link/link_light.png": "24cd47972d555e293f699c6e49cfd913",
"assets/assets/icons/linkedin/linkedin_default.png": "9600f0eae17e0b7b0d2673183b202b5b",
"assets/assets/icons/linkedin/linkedin_hover_dark.png": "9d9bd8217ad0f5d4bc7956a41d6dee7d",
"assets/assets/icons/linkedin/linkedin_hover_light.png": "153ce8de12b3d8adc5568a2ac95a0126",
"assets/assets/icons/waving_hand.png": "1ec7021b7bb7e643a7154a553f8d7382",
"assets/assets/images/certificates/competency_test_for_software_engineering_expertise/competency_test_for_software_engineering_expertise_01.jpg": "7ac0c323f644521f9497c5ecdae0679f",
"assets/assets/images/certificates/competency_test_for_software_engineering_expertise/competency_test_for_software_engineering_expertise_02.jpg": "279f76d0e9f044616877fc098a8a1bdf",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_01.jpg": "2bc072336b16025aa2d1987e873fca4a",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_02.jpg": "d5f2624ee5e50cf0f3df3c056901edf4",
"assets/assets/images/certificates/dicoding_getting_started_programming_with_dart/dicoding_getting_started_programming_with_dart_03.jpg": "f1adf46c5e4f1fe2bbdf070703f7d5d0",
"assets/assets/images/certificates/dicoding_learn_to_make_flutter_apps_for_beginners/dicoding_learn_to_make_flutter_apps_for_beginners_01.jpg": "328e121cae107c79df0ab32605639eb9",
"assets/assets/images/certificates/dicoding_learn_to_make_flutter_apps_for_beginners/dicoding_learn_to_make_flutter_apps_for_beginners_02.jpg": "f3c506736e0e94686c9a798586e18430",
"assets/assets/images/certificates/it_software_solutions_for_business/it_software_solutions_for_business_01.jpg": "97635dd50def1f383096eaa24243f632",
"assets/assets/images/certificates/polytechnic_english_competence_test/polytechnic_english_competence_test_01.jpg": "7013eceedff721329d1286eb7d921240",
"assets/assets/images/certificates/polytechnic_english_competence_test/polytechnic_english_competence_test_02.jpg": "c070f79e03bacd9a961a7c5cdbbe134c",
"assets/assets/images/certificates/professional_certification_institute_exam/professional_certification_institute_exam_01.jpg": "cc5018d58e0bdb5901dba5d9557885ff",
"assets/assets/images/certificates/professional_certification_institute_exam/professional_certification_institute_exam_02.jpg": "bd284a33be5877bc663ca7b18b47d206",
"assets/assets/images/certificates/test_of_english_for_international_communication/test_of_english_for_international_communication_01.jpg": "cfca7bfc34902f62acde813702b53f3c",
"assets/assets/images/creators_photo/khip01_profile.png": "cddb5aee7b0ea2ca5da00201cc67e025",
"assets/assets/images/projects/cafeapp_khipcafe/cafeapp_khipcafe_cover.jpg": "08f65f35f5b43d95cec01eb6d00acda6",
"assets/assets/images/projects/calculator_gui_java/calculator_gui_java_cover.png": "f2b27e88f3fa5ba96c9cbeb512b1651b",
"assets/assets/images/projects/comment_section_web/comment_section_web_cover.png": "a6e51d18b915116c3d3b67a3ba65e72c",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_2.jpg": "428b8739a04640ba065698dfb305e5ae",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_3.png": "4e3f04664311e74727cac63045e4d30a",
"assets/assets/images/projects/first_web_portfolio/first_web_portfo_cover.jpg": "277f729d099d54ed918084e6ef0b07d8",
"assets/assets/images/projects/flutter_portfolio/flutter_portfolio_cover.png": "8089c74a501706e7f3f851097648d458",
"assets/assets/images/projects/kalkulator_basic_cpp/kalkulator_basic_cpp.png": "e63abdcbeacdabb0abcf626853ecbfc4",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_2.jpg": "60fdb137510bb6f50bcdb35efed6cb55",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_3.jpg": "0062e7e86086b631d8eb09840469ec88",
"assets/assets/images/projects/restaurant_khip01/restaurant_khip01_cover.png": "6b4b205a38d3f025ca39b453d4e98faf",
"assets/assets/images/projects/rock_papper_scissors_game/rock_papper_scissors_game_2.png": "cc46aebd7d9ed6286e926b5c3f3b2b6e",
"assets/assets/images/projects/rock_papper_scissors_game/rock_papper_scissors_game_cover.png": "c46442ae71ea727ace919c3ac137569e",
"assets/assets/images/projects/scanthesis/scanthesis_2.png": "fd546d0f899b0fa45866605f906145ed",
"assets/assets/images/projects/scanthesis/scanthesis_3.png": "f7f8c0193f70379e22313857a69f05cd",
"assets/assets/images/projects/scanthesis/scanthesis_4.png": "f7ddbba0b4aa6888a08227373276b1e8",
"assets/assets/images/projects/scanthesis/scanthesis_5.png": "c32410d3d82f8e71a2b53107cbbc6a3d",
"assets/assets/images/projects/scanthesis/scanthesis_cover.jpg": "77c3e886d163138efa57f647f75a372e",
"assets/assets/images/projects/spppayment_spppay/spppayment_spppay_2.jpg": "131d3ae2528fc003b8d54367f976afda",
"assets/assets/images/projects/spppayment_spppay/spppayment_spppay_cover.jpg": "62424a9af155203e8a1b58275e49e398",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_2.jpg": "d1b099533bc19edc541aea86ec64a723",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_3.jpg": "940fac08c8a876e2712865b82e747dfe",
"assets/assets/images/projects/spppayment_spppay_v2/spppayment_spppay_v2_cover.jpg": "e87325fb8cd320e08f49c9b281761e03",
"assets/assets/images/projects/todolist_app/todolist_app_2.jpg": "b1a194f0e06495b9620ad15c263835af",
"assets/assets/images/projects/todolist_app/todolist_app_3.jpg": "c18ce0d61ebf044a26d1d02487b17b51",
"assets/assets/images/projects/todolist_app/todolist_app_4.jpg": "862a1d41fff2d6045c95ed1b1ef79ed7",
"assets/assets/images/projects/todolist_app/todolist_app_cover.jpg": "08207db4e03b6410c82adb8faf7b72e1",
"assets/assets/lato_fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/lato_fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/lato_fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/lato_fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/lato_fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/lato_fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/lato_fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/lato_fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/lato_fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/lato_fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/FontManifest.json": "f09794c75d8212f5a0148a5f7173f27d",
"assets/fonts/MaterialIcons-Regular.otf": "0973f3115c164bdf46686dcfa65e3967",
"assets/NOTICES": "6bb5acf4bd1868a09ecc13cefc6068bd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"browserconfig.xml": "a493ba0aa0b8ec8068d786d7248bb92c",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon-16x16.png": "3807d1ab0824f5ea43536edb57bfca49",
"favicon-32x32.png": "26e2e9dd3f46b5d552fb296009591c01",
"favicon.ico": "37d805c70cde765ba36478f63d153599",
"favicon.png": "3807d1ab0824f5ea43536edb57bfca49",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "79808a4b212fb980c5a008eb739fd648",
"icons/Icon-192.png": "cb9887be9a24f48787c837ffb4dd41a2",
"icons/Icon-512.png": "6d32843072490bc6ee4ff0e1c24cf76e",
"icons/Icon-maskable-192.png": "2d91e1a5a3f9e13ae381b358c0f33993",
"icons/Icon-maskable-512.png": "edae6bf6e65bd6a49e27eedb7a528a0f",
"index.html": "dff1e2a24c3f44f1b7cc69e8d174d4ec",
"/": "dff1e2a24c3f44f1b7cc69e8d174d4ec",
"main.dart.js": "b8e9c846bb166383365d015d9901c23c",
"main.dart.mjs": "6371f6bd95f1f6e26b06edb9c837f08f",
"main.dart.wasm": "661fe6afe739105d85df6942c2a2913e",
"main.dart.wasm.map": "4bf6781c6c12d3d4890f64ab862f68e2",
"manifest.json": "c4ba46dc44243c15d8608d8214d3fe8b",
"mstile-150x150.png": "06f809268e5597b85054fab810990e67",
"safari-pinned-tab.svg": "5910c3c326ee327916d389c1ee3758d6",
"site.webmanifest": "a9846ff2ab8658a079410e7f00864940",
"version.json": "cb0239f6211614b671ba2a6b4e1e780f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
