module Kernel
  def low_windows?
    !(RUBY_PLATFORM =~ /win32|mswin|mingw/).nil?
  end
end
