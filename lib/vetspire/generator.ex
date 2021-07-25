defmodule Vetspire.Generator do
  @moduledoc false

  def target_path(source_dir_name, target_dir) do
    file_name =
      source_dir_name
      |> String.slice(11, String.length(source_dir_name))
      |> Recase.to_title()
      |> Kernel.<> ".jpg"

    Path.join(target_dir, file_name)
  end

  def source_path(source_dir) do
    File.cd(source_dir)
    [keep | _] = File.ls!
    Path.join(source_dir, keep)
  end

  def images_dir(root_dir) do
    root_dir
    |> Path.join("assets")
    |> Path.join("static")
    |> Path.join("images")
  end

  def prepare_files(source_dir) do
    images_dir = images_dir(File.cwd!)
    File.cd(source_dir)
    File.ls!
    |> Enum.each(fn(dog_dir) ->
      dog_path = Path.join(source_dir, dog_dir)
      source = source_path(dog_path)
      target = target_path(dog_dir, images_dir)
      File.rename(source, target)
    end)
  end
end
