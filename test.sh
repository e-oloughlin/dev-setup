exists()
{
  command -v "$1" >/dev/null 2>&1
}

if exists brew; then
  echo "brew already installed"
  exit
else
  echo "brew could not be found"
  exit
fi
