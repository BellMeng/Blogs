# Conformer: Local Features Coupling Global Representations for Visual Recognition




<extoc></extoc>

## 一、摘要

​	在卷积神经网络中，卷积运算擅长提取局部特征，但是难以捕获全局特征。在visual Transformer中，级联的SA模块可以捕获远程特征依赖，但是他会破坏局部特征细节。在本文中，提出了一种称为Conformer的混合网络结构，利用卷积和自注意力机制来增强表示学习。Conformer的思想来源于特征耦合单元(FCU)，它以交互式的方式融合不同分辨率下的局部特征和全局表示。Conformer采用并行结构，最大限度的保留了局部特征和全局表示。实验表明，在可比的参数复杂度下，Conformer在ImageNet上的性能比visual Transformer(DeiT-B)高出2.3%。

[Code](https://github.com/pengzhiliang/Conformer)

## 二、引言

​	卷积神经网络推动了计算机视觉任务如图像分类、目标检测和实例分割等任务的进步。这很大程度上归功于卷积运算，它能以一种分层的方式收集局部特征，来表示图像。尽管CNN在局部特征提取上有优势，但在获取全局表示方面仍然存在困难，如视觉元素之间的关系，这对于高级计算机视觉任务来说是至关重要的。这里有一种最直观的解决方案就是扩大感受野，但是这就会需要更密集的池化操作，但是也会损害池化操作。

​	最近，Transformer结构已经被引入到可视化任务中，ViT方法通过将每个图像分割为带有位置嵌入的小块来构造一个令牌序列(token)，并应用级联Transformer来提取参数化向量作为视觉表示。由于自我注意力机制和MLP结构，visual Transformer反应了复杂的空间变换和远程依赖，构成了全局表示，但是visual transformer忽略了局部特征细节，降低了背景和前景的可分辨性。改进后的visual transformer提出了一种标记化模块或利用CNN特征图作为输入标记来捕获特征邻近信息，然而，如何精确的嵌入局部特征和全局表示的问题仍然存在。

本文的主要贡献如下：

- 提出了一种双网络结构，称为Conformer，它最大限度的保留了局部特征和全局表示。
- 提出了特征耦合单元FCU，以交互方式将卷积局部特征与基于Transformer的全局表示融合。
- 在可对比的参数复杂性下，Conformer的性能显著优于CNN和visual Transformer。Conformer继承了CNN和visual transformer结构的泛化优势，显示出称为通用骨干网络的巨大潜力。

## 三、模型相关

<img src="./images/image-20210916111514046.png" alt="image-20210916111514046" style="zoom:67%;" />

为了利用局部特征和全局特征，本文提出了一个并行的网络结构，如上图所示。

考虑到两种方式特征的互补性，在Conformer中，模型中连续的从transformer分支向特征图中提供全局上下文信息，以增强CNN分支的全局感知能力。同样，CNN分支的局部特征被逐步反馈到Patch Embeddings中，以丰富Transformer分支的局部细节，这样就构成了一个交互的过程。

<img src="./images/image-20210916112647973.png" alt="image-20210916112647973" style="zoom:80%;" />

具体实现上，Conformer由一个stem模块、双分支、桥接双分支的FCU和每个分支上的分类器（FC)组成。Stem模块是一个步长为2的7×7卷积和步长为2的3×3 max pooling，用于提取初始局部特征，然后分别送入到两个分支中。CNN分支和Transformer分支分别由N个重复卷积和Transformer块组成（具体设置如上表所示）。这种并发结构意味着CNN和Transformer分支分别可以最大限度地保留局部特征和全局表示。FCU被提出作为一个桥接模块，将CNN分支的局部特征与Transformer分支的全局表示融合。沿着这些分支结构，FCU会以交互式的方式逐步融合feature map和patch embedding。

