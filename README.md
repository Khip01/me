# gh-pages

### 🕵️‍♂️ WHERE did these files come from?
These files come from the build results of the Flutter web application project. This specific build is optimized using **WebAssembly (Wasm)** to deliver near-native performance.

<br>

## 📋 Steps
Here is how to generate the following files:
- Go to the project directory: ```cd flutter_web_app```
- Run the build command: ```flutter build web --wasm --release``` 
  *(Note: The `--wasm` flag smartly performs a dual-compilation, building both Wasm and a JavaScript (CanvasKit) fallback).*
- This will create a new folder ```build/web/``` and its contents.
- Finally, all the contents of the ```build/web``` folder will be placed in this ```gh-pages``` branch.

<br>

## 📚 References
For more details on how the fallback architecture works:

**[Flutter Docs - WebAssembly (Wasm) Support](https://docs.flutter.dev/platform-integration/web/wasm#open-the-app-in-a-compatible-web-browserm)**
> *"Even with the `--wasm` flag, Flutter will still compile the application to JavaScript. If WasmGC support is not detected at runtime, the JavaScript output is used so the application will continue to work in all major browsers."*

**[Flutter Docs - Web Renderers | Web Assembly Build Mode (`--wasm`)](https://docs.flutter.dev/platform-integration/web/renderers#webassembly-build-mode)**
> *"This mode makes both `skwasm` and `canvaskit` available. `skwasm` requires WasmGC, which is not yet supported by all modern browsers. Therefore, at runtime Flutter chooses `skwasm` if garbage collection is supported, and falls back to `canvaskit` if not."*
