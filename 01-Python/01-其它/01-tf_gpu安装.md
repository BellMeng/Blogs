# TensorFlow GPU版本安装

## 1. 准备

安装好Anaconda、安装好显卡驱动

## 2. 安装步骤

1. 在Anaconda中创建虚拟环境，指定要安装的tensorflow需要的python版本，并进入环境。

   ```shell
   > conda create -n tf-gpu python=3.7
   > conda activate tf-gpu
   ```

2. 安装tensorflow所依赖的cudatoolkit，cudnn，[版本对应关系](https://tensorflow.google.cn/install/source_windows?hl=en#gpu)。

   如果依赖库中有对应版本的cudatoolkit和cudnn，那么可以直接使用conda命令安装。

   ```shell
   > conda install cudatoolkit=x.x cudnn
   ```

   如果没有所需的版本，那么就需要到NVIDIA官网下载cuda以及对应的cudnn进行手动安装。

3. 安装tensorflow-gpu，使用conda命令和pip命令安装都可以(建议使用pip命令)

   ```shell
   > pip install tensorflow-gpu==x.x.x
   ```

   > Tips👋：
   >
   > - pip命令安装使用国内源会比较快，在命令后面通过`-i`指定源地址例如:`pip install tensorflow-gpu==x.x.x -i https://pypi.douban.com/simple`

4. 验证是否安装成功

## 3. 加速安装小技巧🎉

1. 如果使用默认源安装比较慢，可以切换为清华镜像源
2. 如果清华镜像源总是下载过程中中断，可以尝试连接手机热点来加快下载

> 切换清华镜像源：
>
> - 使用`conda config --set show_channel_urls yes`在家目录下生成`.condarc`文件
>
> - 将`.condarc`文件中的内容替换如下：
>
>   ```yaml
>   channels:
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/simpleitk/
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/win-64/ #如果为linux系统，则将win换成linux即可
>     - defaults
>   show_channel_urls: true
>   channel_alias: https://mirrors.tuna.tsinghua.edu.cn/anaconda
>   default_channels:
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
>     - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
>   custom_channels:
>     conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>     msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>     bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>     menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>     pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>     simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
>   ```