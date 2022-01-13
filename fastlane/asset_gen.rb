# coding: utf-8
# XCodeにpdf形式の.imagesetファイルを生成します
# やっていることとしては{画像名}.imagesetというディレクトリの中に
# 指定の形式のJSONファイルと画像ファイルを設置しているだけです
require 'fileutils'
require "json"

def make_pdf_imageset(output_dir:, dir:, image_name:)
  FileUtils.mkdir_p("#{dir}/#{image_name}.imageset")
  FileUtils.cp("#{output_dir}/#{image_name}_light.pdf", "#{dir}/#{image_name}.imageset/#{image_name}_light.pdf")
  FileUtils.cp("#{output_dir}/#{image_name}_dark.pdf", "#{dir}/#{image_name}.imageset/#{image_name}_dark.pdf")
  FileUtils.cp("#{output_dir}/#{image_name}_light.pdf", "#{dir}/#{image_name}.imageset/#{image_name}.pdf")
  open("#{dir}/#{image_name}.imageset/Contents.json", "w") do |io|
    content_json = content_json_hash()
    p "output #{image_name}.imageset"
    content_json[:images] = [
      image_json_hash(image_name: "#{image_name}_dark", appearance: "dark"),
      image_json_hash(image_name: "#{image_name}_light", appearance: "light"),
      image_json_hash(image_name: "#{image_name}", appearance: nil)
    ]
    JSON.dump(content_json, io)
  end
end

def rewrite_asset_dir(dir:)
  `rm -rf #{dir}`
  Dir.mkdir(dir)
  open("#{dir}/Contents.json", "w") do |io|
    JSON.dump(content_json_hash(), io)
  end
end

def appearance_json_hash(mode:)
  return {
    :appearance  => "luminosity",
    :value => mode
  }
end

def image_json_hash(image_name:, appearance:)
  json = {
    :idiom => "universal",
    :filename => "#{image_name}.pdf"
  }
  if appearance != nil
    json[:appearances] = [appearance_json_hash(mode: appearance)]
  end
  return json
end

def content_json_hash()
  return {
    :info => {
      :version => 1,
      :author => "xcode"
    }
  }
end

def make_asset_code(dir)
  p 'start..'
  Dir.glob("#{dir}/*.imageset") { |filename| FileUtils.rm_rf(filename) }
  Dir.glob("#{dir}/*.pdf")
    .filter { |file| file.end_with?("_light.pdf") }
    .map { |file| file.gsub("_light.pdf", "").gsub(".pdf", "") }
    .each { |filename|
        p filename
    make_pdf_imageset(output_dir: dir,
                      dir: dir,
                      image_name: filename.gsub("#{dir}/", ""))
  }
  p 'Complete!'
end
