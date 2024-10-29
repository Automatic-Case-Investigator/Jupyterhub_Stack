pip3 install tensorflow[and-cuda]

echo "Writing environment variables in ~/.bashrc"
echo '
export NVIDIA_DIR=$(dirname $(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)")))
for dir in $NVIDIA_DIR/*; do
    if [ -d "$dir/lib" ]; then
        export LD_LIBRARY_PATH="$dir/lib:$LD_LIBRARY_PATH"
    fi
done' >> ~/.bashrc

echo "Now run \"source ~/.bashrc\" to complete the installation"