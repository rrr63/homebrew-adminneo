class Adminneo < Formula
  desc "Database management in a single PHP file"
  homepage "https://www.adminneo.org/"
  url "https://www.adminneo.org/files/5.1.1/__/adminneo-5.1.1.zip"
  sha256 "4fba21e80933b7c99a5d4fcd152d6d225b04eb1c48516fc0276f63d14e7a9986"
  license "Apache-2.0"
  version "5.1.1"

  depends_on "php"

  def install
    libexec.install "adminneo-5.1.1.php" => "adminneo.php"
    libexec.install "adminneo-plugins"

    (bin/"adminneo").write <<~EOS
      #!/bin/bash
      php -S 127.0.0.1:8080 -t "#{libexec}" "#{libexec}/adminneo.php"
    EOS
  end

  test do
    system "php", "-l", "#{libexec}/adminneo.php"
  end
end
