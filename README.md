# ppip
Personalized pip

this tool is a wraper to pip only it allows you to save a package with an alias

## Usage

### Install
install a pip package

```
ppip install pprintpp
```

install a pip package with an alias

```
ppip install pprintpp==0.2.1 -a pprintpp_0_2_1
ppip install pprintpp==0.2.1 --as pprintpp_0_2_1
ppip install pprintpp==0.2.1 --alias pprintpp_0_2_1
```

### Uninstall
uninstall a pip package

```
ppip uninstall pprintpp
```

uninstall a pip package with an alias

```
ppip uninstall -a pprintpp_0_2_1
ppip uninstall --as pprintpp_0_2_1
ppip uninstall --alias pprintpp_0_2_1
```

### Install Requirements
install a pip package using requirements file

```
ppip install-requirements requirements.txt
```

requirements.txt

```
pprintpp
pprintpp==0.2.1 --as pprintpp_0_2_1
```

this'll install both latest pprintpp and pprintpp_0_2_1

### Important Note
You cant use '.' in your packaage alias since you wouldn't be able to import it!


## Code Usage

After downloadig package like this:
```
ppip install pprintpp==0.2.1 --as pprintpp_0_2_1
```

you'll import it like this:
```
# instead of import pprintpp
import pprintpp_0_2_1.pprintpp
```
