class Adminneo < Formula
  desc "Database management in a single PHP file"
  homepage "https://www.adminneo.org/"
  url "https://www.adminneo.org/files/5.1.0/__/adminneo-5.1.0.zip"
  sha256 "4fba21e80933b7c99a5d4fcd152d225b04eb1c48516fc0276f63d14e7a9986"
  license "Apache-2.0"
  version "5.1.0"

  depends_on "php"

  def install
    libexec.install "adminneo-5.1.0.php" => "adminneo.php"
    libexec.install "adminneo-plugins"

    (bin/"adminneo").write <<~EOS
      #!/bin/bash
      PORT="\${ADMINNEO_PORT:-8080}"  # Utilise la variable ADMINNEO_PORT ou 8080 par défaut
      php -S 127.0.0.1:$PORT -t "#{libexec}" "#{libexec}/adminneo.php"
    EOS
  end

  test do
    system "php", "-l", "#{libexec}/adminneo.php"
  end
end
