# -*- coding: utf-8 -*-
module Lokka
  module Helpers
    URL = {
      :rss      => "http://www.google.com/ig/add?source=atgs&feedurl=http://a-newcomer.com",
      :twitter  => "https://twitter.com/Daic_h",
      :facebook => "http://www.facebook.com/hirata.daichi",
      :github   => "https://github.com/daic-h",
      :aboutme  => "http://about.me/daic_h"
    }

    def social_image_tag service
      link_to(image_tag("#{@theme.path}" + "/assets/images/#{service.to_s}.png"),
              URL[service],
              :target => "_blank",
              :alt => service.to_s.capitalize)
    end

    def press_bread_crumb
      return if @bread_crumbs.size == 1
      @bread_crumbs[0..-2].inject('<ol>') do |html,bread|
        html << "<li><a href=\"#{bread[:link]}\">#{bread[:name]}</a></li>"
      end << "<li>#{@bread_crumbs[-1][:name]}</li></ol>"
    end

    def press_pager(entry, option = {})
      return if entry.blank? || entry.id == nil
      prev_entry, next_entry = Entry(entry.id - 1), Entry(entry.id + 1)
      html =  "<div class=#{option[:class]}>"
      html << "<ul><li class='next'>"
      html <<   "<a class='next-link' href=#{next_entry.link}>#{next_entry.title}</a>" if next_entry
      html << "</li><li class='previous'>"
      html <<    "<a class='previous-link' href=#{prev_entry.link}>#{prev_entry.title}</a>" if prev_entry
      html << "</li></ul></div>"
      html.html_safe
    end

    def press_twitter_widget
      html =<<-HTML
      <script src="http://widgets.twimg.com/j/2/widget.js"></script>
      <script>
        new TWTR.Widget({
          version: 2,
          type: 'profile',
          rpp: 6,
          interval: 6000,
          width: 'auto',
          height: 'auto',
          theme: {
            shell: {
              background: 'none',
              color: '#333'
            },
            tweets: {
              background: 'none',
              color: '#333',
              links: '#d64e80'
            }
          },
          features: {
            scrollbar: false,
            loop: false,
            live: false,
            hashtags: true,
            timestamp: true,
            avatars: false,
            behavior: 'all'
          }
        }).render().setUser('Daic_h').start();
      </script>
      HTML
      html.html_safe
    end
  end
end

