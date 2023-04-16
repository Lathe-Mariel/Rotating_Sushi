VSCode + platformIO + ArduinoFramework のプロジェクトです．

# Driver hardware
A4988を使っています．
A4988とM5StickCとの接続はSTEP（速度パルス）とDIR（回転方向）のみです．
MS1，MS2，MS3は全てプルアップして，1/16マイクロステップ駆動にします．
_RESETと_SLEEPは直結します．
_ENABLEはオープンのまま（結線しない）です．