# carthage_cache_ftps plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-carthage_cache_ftps)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-carthage_cache_ftps`, add it to your project by running:

```bash
fastlane add_plugin carthage_cache_ftps
```

## About carthage_cache_ftps

Allows to publish or install the carthage builds via FTPS to avoid recompilation.

### FTPS

Call the plugin from the Fastfile using

```ruby
carthage_cache_ftps (
  host: "ftp.yourdomain.de",
  user: "username",
  command: "install" #This is the default and can be omitted
)
```

to install from cache and use

```ruby
carthage_cache (
  host: "ftp.yourdomain.de",
  user: "username",
  command: "publish"
)
```

to push the current state to the remote.

Run

```bash
bundle exec fastlane actions carthage_cache_ftps
```

for more information and parameters.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

### Keychain issues
```
SecKeychainAddInternetPassword <NULL>: The specified item already exists in the keychain.
```
If you have to login every time and see an error like this, got to Keychain and delete the carthage cache entry.


## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
