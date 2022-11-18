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
### 4. Commit
`cov-commit-defects --dir idir --stream Intro --host localhost --user admin --password coverity`    
`cov-format-errors --dir idir --html-output <OUTPUTDIR>`  
