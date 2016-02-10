module BabelFish

  class Translation < OpenStruct
    LANGUAGE_NAMES = { en: 'English', fr: 'French' }

    def self.find_by_locale(locale, translations)
      translations.detect { |t| t.locale == locale }
    end

    def english?
      locale.to_sym == :en
    end

    def locale_description
      LANGUAGE_NAMES.fetch(locale)
    end
  end

end
