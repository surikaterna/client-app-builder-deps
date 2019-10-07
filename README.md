# surikaterna/client-app-builder-deps

## Building 

Build image `make build tag=x.y.z`.

## ARG configurations
| Name                   | default  | description                                                |
| ---------------------- | -------- | ---------------------------------------------------------- |
| NODE_VERSION           | v10.16.3 | Determines which node version to use during cordova build. |
| GRADLE_VERSION         | 5.6.2    | Similarly defines gradle version.                          |
| ANDROID_SDK_BUILD_TOOL | 19.1.0   | Similarly defines android sdk version.                     |