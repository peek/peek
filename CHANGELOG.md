# 0.0.1

- Initial release.

# 0.0.2

- Add own tipsy plugin to allow for tooltips.

# 0.0.3

- Change the scope of the .tipsy selector as it's inserted outside of the Glimpse div.

# 0.0.4

- Don't capture ` being pressed when in combination with `cmd`
- Support for [Turbolinks](https://github.com/rails/turbolinks) (#14)

# 0.0.5

- Namespace the tooltips to the `.glimpse-tooltip` class name to not conflict with any application styles for `.tooltip`. (#18)

# 0.0.6

- Added Peek::Views::View#parse_options that gets called within initialize for subclasses to use to parse their options.

# 0.1.0

- Introduced a new JS event `peek:render` that includes the request id and request payload data that is used to update the information in the bar.
- Request information has moved from the `peek/results` partial to an AJAX request that happens on page load, and when PJAX/Turbolinks change pages.
- Removed the need for `peek/results` partial.
- Introduced a Redis and Memcache adapter for multi-server environments to store request payloads.
- Tooltips automatically repositions depending on where the Peek bar is.

# 0.1.1

- Fix bug with how `peek:render` was passing arguments around.

# 0.1.2

- Fix path to memcache adapter - [#34](https://github.com/peek/peek/pull/34) [@grk](https://github.com/grk)
- Prevent namespace collision when using [peek-dalli](https://github.com/peek/peek-dalli) - [#34](https://github.com/peek/peek/pull/34) [@grk](https://github.com/grk)

# 0.1.3

- Remove Redis dependency from Gemfile

# 0.1.4

- Don't access xhr object when not present in pjax:end

# 0.1.5

- Don't trigger `peek:update` event when the peek bar isn't present - [#37](https://github.com/peek/peek/issues/37) [@dewski](https://github.com/dewski)
- Add `after_request` helper method for Peek::Views::View to help reset state

# 0.1.6

- Use `event.which` for normalization between `event.keyCode` and `event.charCode` - [#38](https://github.com/peek/peek/pull/38) [@leongersing](https://github.com/leongersing)

# 0.1.7

- Support all Rails 3.x.x versions by not using `request.uuid` instead `env` - [#39](https://github.com/peek/peek/pull/39) [@bryanmikaelian](https://github.com/bryanmikaelian)

# 0.1.8

- Include the ControllerHelpers directly into `ActionController::Base` - [#41](https://github.com/peek/peek/pull/41) [@lucasmazza](https://github.com/lucasmazza)

# 0.1.9

- Rescue & log Dalli exceptions instead of crashing - [#50](https://github.com/peek/peek/pull/50) [@barunio](https://github.com/barunio)

# 0.1.10

- Take off Responders - [#65](https://github.com/peek/peek/pull/65) [@nwjsmith](https://github.com/nwjsmith)

# 0.2.0

- Add image dependencies for asset compilation - [#67](https://github.com/peek/peek/pull/67) [@fedesoria](https://github.com/fedesoria)
- Update JSON to 1.8.2 for compatibility with Ruby 2.2.2 - [#73](https://github.com/peek/peek/pull/73) [@eitoball](https://github.com/eitoball)
- Use concurrent-ruby gem in favor of deprecated atomic gem. - [#73](https://github.com/peek/peek/pull/73) [@eitoball](https://github.com/eitoball)
- Prevent errors if compatibility mode is enabled for jQuery - [#74](https://github.com/peek/peek/pull/74) [@warseph](https://github.com/warseph)
- Add dependency for coffee-rails for Rails. - [#80](https://github.com/peek/peek/pull/80) [@cllns](https://github.com/cllns)
- Fix deprecation warnings for `helper_method` for future versions of Rails past Rails v5. - [#85](https://github.com/peek/peek/pull/85) [@mgrachev](https://github.com/mgrachev)
- Listen to Turbolinks v5 `turbolinks:load` JS event to trigger peek updates. - [#88](https://github.com/peek/peek/pull/88) [@lucasmazza](https://github.com/lucasmazza)

# 1.0

- Rails 4+ compatibility
  - Update `before_filter` to `before_action` @mkcode
  - Replace GIFs with colors @tarebyte
- Remove CoffeeScript @dewski
- Use Ruby JSON syntax for hashes

# 1.1.0

- Ensure that Peek can handle concurrent requests with a multithreaded application server - [#113](https://github.com/peek/peek/pull/113) [@smcgivern](https://github.com/smcgivern)
- Don't store metrics if no request ID is present - [#112](https://github.com/peek/peek/pull/112) [@rymai](https://github.com/rymai)
