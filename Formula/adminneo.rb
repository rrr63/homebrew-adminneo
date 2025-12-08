class Adminneo < Formula
  desc "Database management in a single PHP file"
  homepage "https://www.adminneo.org/"
  url "https://www.adminneo.org/files/5.2.1/__/adminneo-5.2.1.zip"
  sha256 "c85f624bf68e90e9a1edafffc61f1313e99e68a639ff9eba91263b8d3a193acc"
  license "Apache-2.0"
  version "5.2.1"

  depends_on "php"

  def install
    libexec.install "adminneo-#{version}.php" => "adminneo.php"
    libexec.install "adminneo-plugins"

    (bin/"adminneo").write <<~EOS
      #!/bin/bash
      PORT="\${ADMINNEO_PORT:-8080}"
      while [[ $# -gt 0 ]]; do
      case $1 in
        -p|--port)
          PORT="$2"
          shift 2
          ;;
        *)
          shift
          ;;
      esac
    done
      php -S 127.0.0.1:$PORT -t "#{libexec}" "#{libexec}/adminneo.php"
    EOS
  end

  test do
    system "php", "-l", "#{libexec}/adminneo.php"
  end
end
