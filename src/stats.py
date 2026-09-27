"""Tiny example module so `make verify` exercises real code inside Docker."""


def mean(xs):
    if not xs:
        raise ValueError("mean of empty sequence")
    return sum(xs) / len(xs)
