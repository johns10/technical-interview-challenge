
defmodule Generator do
  @moduledoc """
  Documentation for `State`.
  """
  require EEx
  EEx.function_from_file(:def, :greeting, "dog_page.eex", [:name, :image_dir])

  def generate_html() do
    template_path = Path.absname("dog_page.eex")
    pages_path = Path.absname("pages")
    json_path = Path.absname("assets/js/pages.js")

    File.cd("assets")
    File.cd("images")
    info =
      File.ls!
      |> Enum.map(fn(image_dir) ->
        name = Recase.to_title(image_dir)

        path = Path.absname(image_dir <> ".md", pages_path)
        :ok = File.write(path, EEx.eval_file(template_path, [name: name, image_dir: image_dir]))

        %{image_dir: image_dir <> ".html", name:  name}
      end)

    IO.puts(json_path)
    {:ok, output} = Jason.encode(info)
    File.write(json_path, "data = " <> output)
  end

  def rename_files() do
    File.cd("assets")
    File.cd("images")
    File.ls!
    |> Enum.each(fn(dir) ->
      File.cd(dir)
      [keep | delete] = File.ls!
      File.rename(keep, "image.jpg")
      delete
      |> Enum.each(fn(dir) ->
        path = dir
        |> Path.absname()
        File.rm(path)
      end)
      File.cwd!
      File.cd("..")
    end)
  end
end
