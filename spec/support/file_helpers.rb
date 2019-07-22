# frozen_string_literal: true

module FileHelpers
  def clean_tmp_files(file_paths)
    file_paths.each do |file_path|
      File.truncate(file_path, 0)
    end
  end

  def safe_path(path)
    # Always reason from main spec directory
    File.join(__dir__, "../#{path}")
  end
end
