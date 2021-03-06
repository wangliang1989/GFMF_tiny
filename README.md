# GFMF_tiny

此处是使用 GFMF 的一个最小示例，目的是验证 GFMF 本身的安装和给初学者最基本的使用体验。
使用本示例的最低前提是正确安装了[GFMF](https://github.com/wangliang1989/gfmf) 和 sac。

本示例按照 GPL v3 协议发布，即你可以使用、修改和再发布。但修改后也需要开源（包括增量部分）。
详情请看[GPL v3 协议英文版](LICENSE)

## 文件含义

**本仓库因文件大小的原因，没有包含下面的地震波形文件和格林函数库。**
使用方法中说明了如何获取这部分文件。

                     20180815         地震波形文件
                      LICENSE         GPL v3 协议英文版
                    README.md         本文件
                    cali.conf         搜索配置文件
               cali_grids.txt         网格文件
                       cat.pl         生成地震目录
                         glib         格林函数库
                       run.pl         搜索运行文件
                 stations.txt         台站列表
     wangliang_cali_11_10.txt         我做出来的地震目录
    wangliang_result_cali.txt         我做出来的初步地震目录

## 使用方法

1. 下载[地震波形文件](https://www.jianguoyun.com/p/DfcbAv0Q5s_iCRiVyIkE)和
[格林函数库](https://www.jianguoyun.com/p/DYluM3cQ5s_iCRiLyIkE)并解压

2. 生成格林函数

我在上一步中提供的格林函数库压缩包已经包含了格林函数文件。你可以直接使用，
也可以用下面的步骤自己计算（以 FK 已经正确安装为前提）。我建议初学者先直接用我给的格林函数文件。
**如果你选择自己生成格林函数，千万不要忘记执行 cutglib.pl**。

````bash
cd glib
cp $GFMF/script/run_parallel.pl . # run_parallel.pl 是并行计算格林函数的脚本
cp $GFMF/script/config.pm .       # config.pm 是 run_parallel.pl 依赖的一些子函数
cp $GFMF/script/cutglib.pl .      # 格林函数的处理程序
perl run_parallel.pl cvms5-1.fk   # 计算格林函数
perl cutglib.pl                   # 对格林函数滤波，计算归一化互相关的部分归一化参数
````

目前在 ARM Mac 上使用 cutglib.pl，
**可能**会产生大量 SAC 的警告信息，原因和影响程度未知。

3. 建立工作目录

**在包含了脚本 run.pl 的路径下：**

````bash
mkdir junk # junk 路径下所有文件在搜索前会被删除
````

4. 执行搜索

这一步会非常耗时，而且你的计算机会变得很卡。在运行前，建议关闭其它应用。
我的电脑（价格 6000 多）需要接近 1 小时来完成搜索。
不过，我弟弟说学校配的 3 万块的工作站算了一晚上也没算完。

````bash
perl run.pl junk
````

计算完毕后，`20180815/result_cali.txt` 应该和 `wangliang_result_cali.txt` 的差异微小，
但不必追求完全一致。

5. 生成地震目录

````bash
perl cat.pl
````

`cali_11_10.txt` 应该和 `wangliang_cali_11_10.txt` 的差异微小，但不必追求完全一致。

6. 画图

如果你正确安装了 GMT6，可以画图：

````bash
perl draw.pl
````

如果一切顺利，你应该看到你的结果（蓝色，Your result）
和我的结果（红色，Wangliang result）差别很小。

## 文章下载与引用信息

下载论文及其 BibTex 和 Endnote 文件，请直接前往《地球物理学报》官网：
http://www.geophy.cn/CN/abstract/abstract15922.shtml

> 王亮, 梁春涛. 2021. 以虚拟地震的理论格林函数为模板搜寻小地震. 地球物理学报,64(7): 2374-2393, doi: 10.6038/cjg2021O0361

> WANG Liang, LIANG ChunTao. 2021. Detecting small earthquakes using the theoretical Green's function of virtual earthquakes as templates Chinese Journal of Geophysics(in Chinese), 64(7): 2374-2393, doi: 10.6038/cjg2021O0361

## 已引用本方法的论文

如果你在论文中引用了我的上述论文。无论你的文章的主题为何，你都可以把你的已正式刊出的论文发给我。
我会在此处列出。这样可以让别人知道你的研究工作，潜在地增加你的论文的引用量。
