
compare_files() {
   if cmp -s "$1" "$2"; then
      echo "Files are the SAME."
   else
      echo "Files are DIFFERENT."
   fi
}


compare_with_others() {
   for other_file in *; do
      echo ""
      echo "$other_file"
      compare_files "$1" "$other_file"
   done
}



