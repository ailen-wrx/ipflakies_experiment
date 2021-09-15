victim=$1
test_list=$2
module=$3
project_dir=$4
output_dir=$5

mkdir -p $output_dir
cd $project_dir
for i in $(grep ,$module, $test_list | cut -d, -f1); do
    if [[ "$i" == "$victim" ]]; then
	continue
    fi
    md5=$(echo $i,$victim | md5sum | cut -d' ' -f1)
    pytest $i $victim --csv $output_dir/$md5.csv
    echo $i,$victim,$md5 >> $output_dir/test_mapping.csv
done
cd -
