### testing

# liq = linspace(-2.0, 10.0, 15)
# ill = linspace(0.0, 10.0, 15)
#
# a_grid = Iterators.product(liq, ill)

num_a = 1000
num_s = 2000
num_sa_pairs = num_a * num_s
R = rand(num_sa_pairs)
Q = spzeros(num_sa_pairs, num_s)
gc()

import Base.Iterators: flatten, repeated
get_s_indices(num_s, num_a) = flatten(i for j in 1:num_a, i in 1:num_s)
get_a_indices(num_s, num_a) = flatten(repeated(1:num_a, num_s))

a_ind = collect(get_a_indices(num_s, num_a))
s_ind = collect(get_s_indices(num_s, num_a))

@time DiscreteDP(R, Q, 0.95, num_s, num_a)
@time DiscreteDP(R, Q, 0.95, s_ind, a_ind)

a_indices = get_a_indices(num_s, num_a)
a_indptr = 1:num_a:(num_a*num_s+1)
vals = rand(num_a*num_s)
out = zeros(num_s)

@time tmp1 = s_wise_max!(a_indices, a_indptr, vals, out)

out = zeros(num_s)
cai = collect(a_indices)
caip = collect(a_indptr)
@time tmp2 = s_wise_max!(cai, caip, vals, out)


out
