class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 640
          @height = 360
      else
          @width = $2.to_i
          @height = $3.to_i
      end
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)
    # "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"http://www.youtube.com/embed/#{@id}\" frameborder=\"0\"allowfullscreen></iframe>"
    # "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"http://www.youtube.com/embed/#{@id}?color=white&theme=light\"></iframe>"
    "<div style=\"position:relative;height:0;padding-bottom:56.25%\"><iframe src=\"https://www.youtube-nocookie.com/embed/#{@id}?rel=0?ecver=2?color=white&theme=light\" width=\"#{@width}\" height=\"#{@height}\" frameborder=\"0\" style=\"position:absolute;width:100%;height:100%;left:0\" allowfullscreen></iframe></div>"
  end

  Liquid::Template.register_tag "youtube", self
end
