require 'active_support'
require 'active_support/inflector'

module BabelFish
  extend ActiveSupport::Concern

  module ClassMethods
    def is_translatable(*attr_names)
      unless const_defined?(:TRANSLATABLE_ATTRIBUTES)
        const_set(:TRANSLATABLE_ATTRIBUTES, attr_names)
      end

      attr_names = attr_names.map(&:to_s).map(&:singularize)
      attr_locales = I18n.available_locales.product(attr_names)
      current_locale = -> { I18n.locale }

      define_method(:get_translation) do |attr_name, locale|
        locale = locale.is_a?(Proc) ? locale.call : locale
        translations = send(attr_name.pluralize)
        # translation = Translation.find_by_locale(locale, translations)
        # translation.value
        translations[locale]
      end

      define_method(:set_translation) do |attr_name, locale, val|
        translations = send(attr_name.pluralize)
        # translation = Translation.find_by_locale(locale, translations)
        # translation.value = val
        translations[locale] = val
      end

      define_method(:any_translations?) do |attr_name|
        send(attr_name.pluralize).values.any? do |value|
          # to not have dependency on RoR #present?
          !(value.respond_to?(:empty?) ? !!value.empty? : !value)
        end
      end

      define_method(:has_translation?) do |attr_name, locale|
        value = get_translation(attr_name, locale)
        # to not have dependency on RoR #present?
        !(value.respond_to?(:empty?) ? !!value.empty? : !value)
      end

      attr_locales.each do |(locale, attrib)|
        # defines getter as attrib_locale e.g. label_en, label_fr
        define_method("#{attrib}_#{locale}") do
          get_translation(attrib, locale)
        end

        # defines setter as attrib_locale= e.g. label_en=, label_fr=
        define_method("#{attrib}_#{locale}=") do |val|
          set_translation(attrib, locale, val)
        end
      end

      attr_names.each do |attr_name|
        attr_accessor attr_name.pluralize

        # defines getter as attrib(:locale) e.g. label(:en), label(:fr), label
        define_method(attr_name) do |locale = current_locale|
          get_translation(attr_name, locale)
        end

        # defines setter for current locale as attrib= e.g. label=
        define_method("#{attr_name}=") do |val|
          locale = current_locale.call
          set_translation(attr_name, locale, val)
        end

        define_method("#{attr_name}_any_translations?") do
          any_translations?(attr_name)
        end

        define_method("#{attr_name}_has_translation?") do |locale|
          has_translation?(attr_name, locale)
        end
      end
    end
  end
end
