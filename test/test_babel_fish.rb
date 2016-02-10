require 'helpers/lib_test_helper'

describe BabelFish do
  let(:texts) { {en: 'english text', fr: 'french text'} }
  let(:other_texts) { {en: 'other english text', fr: 'other french text'} }
  # let(:en_trans) { BabelFish::Translation.new(locale: :en, value: 'english text') }
  # let(:fr_trans) { BabelFish::Translation.new(locale: :fr, value: 'french text') }
  # let(:text_translations) { [en_trans, fr_trans] }

  subject { HostDummy.new(texts: texts, descriptions: texts) }

  describe 'text translations' do
    describe 'TRANSLATABLE_ATTRIBUTES' do
      it { HostDummy::TRANSLATABLE_ATTRIBUTES.must_equal [:texts, :descriptions] }
    end

    describe '#texts' do
      it { subject.texts.must_equal texts }
    end

    describe 'current locale' do
      before(:each) { I18n.locale = :fr }

      it { subject.text.must_equal texts[:fr] }
    end

    describe '#text_any_translations?' do
      describe 'when at least one translation is present' do
        before(:each) { subject.text_fr = '' }

        it { subject.text_any_translations?.must_equal true }
      end

      describe 'when all translations are blank' do
        before(:each) do
          subject.text_en = nil
          subject.text_fr = ''
        end

        it { subject.text_any_translations?.must_equal false }
      end
    end

    describe '#text_has_translation?' do
      describe 'when locale translation is present' do
        it { subject.text_has_translation?(:en).must_equal true }
      end

      describe 'when locale translation is blank' do
        before(:each) { subject.text_en = '' }

        it { subject.text_has_translation?(:en).must_equal false }
      end
    end

    I18n.available_locales.each do |locale|
      describe 'when locale is english' do
        before(:each) { I18n.locale = locale }

        describe 'getters' do
          it { subject.public_send("text_#{locale}").must_equal texts[locale] }
          it { subject.text(locale).must_equal texts[locale] }
        end

        describe 'setters with default locale' do
          before(:each) { subject.text = other_texts[locale] }

          it { subject.public_send("text_#{locale}").must_equal other_texts[locale] }
          it { subject.text(locale).must_equal other_texts[locale] }
        end

        describe 'setters with underscore locale' do
          before(:each) { subject.public_send("text_#{locale}=", other_texts[locale]) }

          it { subject.public_send("text_#{locale}").must_equal other_texts[locale] }
          it { subject.text(locale).must_equal other_texts[locale] }
        end
      end
    end
  end

  describe 'description translations' do
    describe 'default locale' do
      before(:each) { I18n.locale = :fr }

      it { subject.description.must_equal texts[:fr] }
    end

    I18n.available_locales.each do |locale|
      describe 'when locale is english' do
        before(:each) { I18n.locale = locale }

        describe 'getters' do
          it { subject.public_send("description_#{locale}").must_equal texts[locale] }
          it { subject.description(locale).must_equal texts[locale] }
        end

        describe 'setters with default locale' do
          before(:each) { subject.description = other_texts[locale] }

          it { subject.public_send("description_#{locale}").must_equal other_texts[locale] }
          it { subject.description(locale).must_equal other_texts[locale] }
        end

        describe 'setters with underscore locale' do
          before(:each) { subject.public_send("description_#{locale}=", other_texts[locale]) }

          it { subject.public_send("description_#{locale}").must_equal other_texts[locale] }
          it { subject.description(locale).must_equal other_texts[locale] }
        end
      end
    end
  end
end
