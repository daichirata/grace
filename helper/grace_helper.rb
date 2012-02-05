# -*- coding: utf-8 -*-
module Lokka
  module Helpers
    SOCIAL_URL = {
      :rss      => "http://www.google.com/ig/add?source=atgs&feedurl=http://a-newcomer.com",
      :twitter  => "https://twitter.com/Daic_h",
      :facebook => "http://www.facebook.com/hirata.daichi",
      :github   => "https://github.com/daic-h",
      :aboutme  => "http://about.me/daic_h"
    }

    def grace_social_tag service
      link_to(image_tag("#{@theme.path}" + "/assets/images/social/#{service.to_s}.png"),
              SOCIAL_URL[service],
              :target => "_blank",
              :alt => service.to_s.capitalize)
    end

    def apply_continue_reading_with_grace_continue_reading(posts)
      posts.each do |post|
        post.body.sub!(/<!-- ?more ?-->.*/m, %Q(<a class="read-more" href=\"#{post.link}\">#{I18n.t('continue_reading')}</a>))
      end
      posts
    end
    alias_method_chain :apply_continue_reading, :grace_continue_reading


    def grace_pager(entry, option = {})
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

    def grace_twitter_widget
      html =<<-HTML
      <script src="http://widgets.twimg.com/j/2/widget.js"></script>
      <script>
        new TWTR.Widget({
          version: 2,
          type: 'profile',
          rpp: 5,
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
              color: '#FFF',
              links: '#666'
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

    def grace_tag_cloud(&block)
      tags = Tag.all.sort_by(&:name)
      level = %w(level6 level5 level4 level3 level2 level1)

      max_count = 0
      tags.each {|tag| max_count = tag.taggings.count if tag.taggings.count > max_count }

      tags.each do |tag|
        if max_count > 1
          index = ((tag.taggings.count.to_f / max_count.to_f) * (level.size - 1)).round
        else
          index = 0
        end
        block.call(tag, level[index])
      end
    end
  end
end

