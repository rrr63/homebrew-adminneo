class Adminneo < Formula
  desc "Database management in a single PHP file"
  homepage "https://www.adminneo.org/"
  url "https://www.adminneo.org/files/5.2.0/__/adminneo-5.2.0.zip"
  sha256 "cd46ad478386551c3351f4a9e6e24871bb7368209a7409815e867d7b9d116af9"
  license "Apache-2.0"
  version "5.2.0"

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
