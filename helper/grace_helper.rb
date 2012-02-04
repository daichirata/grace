# -*- coding: utf-8 -*-
module Lokka
  module Helpers
    def apply_continue_reading(posts)
      posts.each do |post|
        post.body.sub!(/<!-- ?more ?-->.*/m, %Q(<a class="read-more" href=\"#{post.link}\">#{I18n.t('continue_reading')}</a>))
      end
      posts
    end

    def grace_short_body
      @short_body ||= self.long_body
    end
  end
end

