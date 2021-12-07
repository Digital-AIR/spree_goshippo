Deface::Override.new(
  virtual_path:  'spree/admin/shared/_main_menu',
  name:          'goshippo_main_menu_tabs',
  insert_top: 'nav',
  text: <<-HTML
        <% if can? :admin, Spree::Goshippo %>
          <ul class="nav nav-sidebar border-bottom" id="sidebarGoshiipo">
          	<%= tab Spree::Goshippo.model_name.human, url: admin_goshippos_path, icon: 'shippo.svg' %>
          </ul>
        <% end %>
HTML
)