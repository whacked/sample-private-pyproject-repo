import toolz as z
import json


def mad_adder(a, b, c):
    out = {
        'result': f'mad adder of a, b, c is {2*a + 3*b + 5*c}',
    }
    return json.dumps(z.assoc(out, 'status', 'wonderful'))


if __name__ == '__main__':
    print(mad_adder(11, 22, 33))

