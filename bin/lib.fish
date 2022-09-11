
function download -a URL -d "Download URL using curl, unless it was already downloaded"
  set NAME (basename $URL)
  echo "Testing if $NAME exists..."
  if test -e $NAME then
    curl -fSL# $URL -o $NAME
  end
end
