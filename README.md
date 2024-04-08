# ChatApp

## Add user avatars:
#### CMD:
* redis:
  ```
  redis-server
  ```

* cmd for devise:
  ```
  bundle exec rails g devise:controllers users
  ```

  ```
  bundle exec rails g devise:views
  ```

#### Gems:
* mini_magick
* image_processing

#### Libs:
* vips (for above gems)
  ```
  brew install vips
  ```
