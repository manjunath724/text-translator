# Text Translator

## Technical Details
- Using
```
ruby '2.5.0'
gem 'rails', '~> 5.2.1'
gem 'sqlite3', '1.3.13'          # Used as a Database
gem 'redis-rails', '5.0.2'       # Used as cache storage
gem 'sidekiq', '3.2.5'           # Used as an adapter for background jobs
```
- Using `rbenv` as the Ruby Version Management tool.

## Implementation Details
- Dictionary words with language and links to words from other languages has to be supplied manually.
- `redis_store` cache is used to retrieve information from cache memory for repeated requests.
- DB is prefered over paid services like [Google Translate](https://github.com/seejohnrun/easy_translate) or [Bing Translations](https://github.com/relrod/bing_translator-gem)

## Steps to setup and run the project on Ubuntu
- Clone the repository using [`git clone`](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository) command.
```
git clone https://github.com/manjunath724/text-translator.git
```
- CD into the repository and run 
```
bundle install
``` 
and 
```
rake db:create db:migrate
```
- Start redis, sidekiq and rails server
```
redis-server
```
```
bundle exec sidekiq
```
```
rails server
```
- Open postman and visit
  - POST localhost:3000/api/v1/dictionaries/translate    # To translate text
    - params: word=hello from=en to=es
  - POST localhost:3000/api/v1/dictionaries              # To add an entry into DB
    - params: dictionary[word]=hola dictionary[language]=es dictionary[variant_ids][]=1
  - GET localhost:3000/api/v1/dictionaries               # To view all entries in DB

## Pending
- Caching is malfunctioning, everytime there is an update in the DB, all entries will be displayed.
- Rspec test case scenarios
