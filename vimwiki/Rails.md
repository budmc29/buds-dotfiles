# Rails Notebook

- generate a model
```
generate model Name title:string text:text

```

- model generation types
```
:primary_key, :string, :text, :integer, :float, :decimal, :datetime, :time
:date, :binary, :boolean

```

- split rows for bootstrap when displaying content
```
<% @red.each_slice(3) do |res| %>
 <div class="row">
  <% red.each do |r| %>
    <div class="col-md-12"></div>
  <% end %>
 </div>
<% end %>

```

- uninstall gem
```
gem uninstll name

```

- import data/models to Tire / Elasticsearch
```
rmv use ...
bundle exec rake environment tire:import:all FORCE=true RAILS_ENV=staging

```

- display mysql queries in rails console
```
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.connection_pool.clear_reloadable_connections!

```
