## 步骤
### 1. Configure
1.1 配置`gcc`:`cov-configure --gcc`  
1.2 列出所有支持的编译器:`cov-configure -lsct`    
### 2. Build
`cov-build --dir idir make`  
`cov-build --dir idir make -f z8o.mk clean build`  
`cov-build --dir idir msbuild xyz.sln /t:Rebuild`    
`cov-build --dir idir devenv xyz.c*proj /Rebuild`    
`cov-build --dir idir devenv xyz.sln`    
`cov-build --dir idir build.sh <args>`    
`cov-build --dir idir runbuild.bat <args>`    
`cov-build --dir idir ant install`    
`cov-build --dir idir mvn clean compile`    
### 3. Analyze
`cov-analyze --dir idir`    
`cov-analyze --dir idir --all`    
`cov-analyze --dir idir --all --checker-option OVERRUN:check_nonsymbolic_dynamic:true`    
### 4. Commit
`cov-commit-defects --dir idir --stream Intro --host localhost --user admin --password coverity`    
`cov-format-errors --dir idir --html-output <OUTPUTDIR>`  
### 5. 替换函数或宏  
#### 以assert 为例  
1. 更改`./installfile/config/user_nodefs.h`文件   

```  
#include<assert.h> 
#nodef Assert assert
#nodef AssertEx AssertExModel
#define AssertExModel(expr,msg) {assert(expr);}
```  
>1.1 注意加上`#include<assert.h>`头文件;  
>1.2 把`user_nodefs.h` 当做一个普通的c文件，会同项目一起编译;  

2. 可以在 `./install/library/my_assert.cpp` 中加入函数的实现,  
```
extern void assert(int x);
void assert_model(int x)
{
    assert(x);
}
```
>2.1 `cov-make-library my_assert.cpp`
>2.2 `cov-analyze --dir ./ --user-model-file ./install/config/user_models.xmldb`
>2.3 注意文件名后缀，如果为c项目则为`my_assert.c`, c++为 `my_assert.cpp`  
### 6. CODEXM   
`cov-analyze --dir mycxm --codexm mychecker.cxm`  
### 7. 编译日志
`build-log.txt`