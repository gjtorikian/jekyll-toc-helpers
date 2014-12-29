module Jekyll
  module TOCHelper
    def check_existing_content(context, prefix, id)
      context.registers[:site].data["#{prefix}_#{id}"]
    end

    def construct_datafile(context, keys)
      datafile = context.registers[:site].data

      while path = keys.shift
        datafile = datafile[path]
      end

      datafile
    end
  end

  class TOCTag < Liquid::Tag
    include TOCHelper

    def initialize(tag_name, text, tokens)
      super
      keys = text.strip.split('.')
      keys.shift(2) # this is just site.data
      @keys = keys
      @id = keys.join('.')
    end

    def render(context)
      existing_content = check_existing_content(context, 'toc', @id)
      return existing_content unless existing_content.nil?

      list = []
      datafile = construct_datafile(context, @keys)

      datafile.each do |line|
        if line.is_a? Hash
          line.each_pair do |parent, children|
            list << "- [#{parent}](#{Utils.slugify parent})"
            children.each do |subsection|
              list << "  - [#{subsection}](#{Utils.slugify subsection})"
            end
          end
        else
          list << "- [#{line}](#{Utils.slugify line})"
        end
      end

      context.registers[:site].data["toc_#{@id}"] = list.join("\n")
      context.registers[:site].data["toc_#{@id}"]
    end
  end

  class NextPrevTag < Liquid::Tag
    include TOCHelper

    def initialize(tag_name, text, tokens)
      super
      keys = text.strip.split('.')
      keys.shift(2) # this is just site.data
      @keys = keys
      @id = keys.join('.')
    end

    def render(context)
      existing_content = check_existing_content(context, 'next_prev', @id)
      return existing_content unless existing_content.nil?

      list = []
      datafile = construct_datafile(context, @keys)

      datafile.each do |line|
        if line.is_a? Hash
          line.each_pair do |parent, children|
            list << parent
            children.each do |subsection|
              list << subsection
            end
          end
        else
          list << line
        end
      end

      context.registers[:site].data["next_prev_#{@id}"] = list.join('|')
      context.registers[:site].data["next_prev_#{@id}"]
    end
  end
end

Liquid::Template.register_tag('toc', Jekyll::TOCTag)
Liquid::Template.register_tag('next_prev', Jekyll::NextPrevTag)
