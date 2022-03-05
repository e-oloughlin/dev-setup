which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
  echo "brew NOT installed"
else
  echo "brew installed"
fi
