#!/usr/bin/env python3
import gmpy2
from Crypto.Util.number import *

n = 100022197665255758023386405440532428068443296506811715882779969209600660612423273798629913666886974173893409971573707514652753648995596558261888641319855588664291227206258229049015656466704578874393272481185485570908937834236897179795699694426303105018343086102629111973573100291720115819693781750817579532379
e = 77146328467692501423618104343884572272197813687938082939311442208499733898813928753450758642961769982268542007666333480618061851019773416861566880405186075618753087162924843426445248183703210817049783979637434682608250847332993056833293065215525201086118821422111573872560734254052476084057414323083887626961
c = 53629519433483872330714232217869869270130220084401344485298842318124484284615429739270760986791798678537142318979245353640552707006881253555854066592977951081793218238216460200641982979559909932567938106595060942742178411352507693817171983700524968259095998048527942288526206405898463858237237041786188812003

def solve(a, b, c):
    k = b * b - 4 * a * c
    if k < 0 or not is_square(k):
        return []
    sk = isqrt(k)
    return [int((-b + sk) // (2 * a)), int((-b - sk) // (2 * a))]

def wiener(n, e):
    kd = (e / n).continued_fraction().convergents()
    for x in kd:
        k, d = x.numerator(), x.denominator()
        if k == 0:
            continue
        phi = (e * d - 1) // k
        roots = solve(1, phi - n - 1, n)
        if len(roots) == 2:
            p, q = roots
            if p * q == n:
                return (p, q)

p, q = wiener(n, e)
d = inverse(e, (p - 1) * (q - 1))
m = pow(c, d, n)
print(long_to_bytes(m))