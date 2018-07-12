type Errors
    a::Float64 # parameter distribution smoothing
    h::Float64

    odev::Vector{Float64} # σ for observation, param distributions
    pdev::Vector{Float64}

    lb::Vector{Float64} # lower/upper bounds for truncated normal param distrs.
    ub::Vector{Float64}

    function Errors(nparams=9)
        this = new();
        δ = 0.995; # ∃ (0, 1, typically within 0.95-0.99), lower values = less parameter dispersion
        this.a = (3*δ-1)/(2*δ);
        this.h = sqrt.(1-this.a^2);
        this.odev = [30*cm3Tom3];
        # this.pdev = [1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12]; # no params
        # this.pdev = [4e4,2e6,2e-8,1*cm3Tom3,1e-1,2e-1,2e-1,4.5,2.8e7]; # all params
        # this.pdev = [2e4,2e6,1e-9,1e-12,1e-12,1e-12,1e-12,1e-12,1e-5]; # Windkessel only
        # this.pdev = [2e4,2e6,1e-9,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # Windkessel + Emax
        # this.pdev = [2e4,1e-12,1e-9,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # Windkessel - R + Emax
        # this.pdev = [2e4,2e6,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # Windkessel - C + Emax
        # this.pdev = [8e4,4e6,4e-8,1e-12,1e-12,2e-1,1e-12,1e-12,2.8e7]; # Windkessel + Emax + τ2
        # this.pdev = [2e4,2e6,1e-8,1e-12,1e-12,1e-12,1e-12,2.7,7e6]; # Windkessel + Emax + m2
        # this.pdev = [2e4,2e6,1e-12,1e-12,1e-12,1e-12,1e-12,2.7,7e6]; # Windkessel - C + Emax + m2
        # this.pdev = [2e4,2e6,1e-9,1e-12,1e-12,1e-12,0.1,2.7,7e6]; # Windkessel + Emax + m1 + m2
        # this.pdev = [2e4,1e-12,1e-9,1e-12,1e-12,1e-12,0.1,2.7,7e6]; # Windkessel - R + Emax + m1 + m2
        # this.pdev = [2e4,1e-12,1e-9,1e-12,1e-2,1e-12,0.1,2.7,7e6]; # Windkessel - R + Emax + t1 + m1 + m2
        # this.pdev = [2e4,2e6,1e-12,1e-12,1e-12,1e-12,0.1,2.7,7e6]; # Windkessel - C + Emax + m1 + m2
        # this.pdev = [1e-12,2e6,1e-9,1e-12,1e-12,1e-12,0.1,1e-12,7e6]; # Windkessel - Zc + Emax + m1
        # this.pdev = [1e-12,2e6,1e-12,1e-12,1e-12,1e-12,0.1,2.7,7e6]; # R + Emax + m1 + m2
        # this.pdev = [1e-12,2e6,1e-12,1e-12,1e-12,3e-1,0.1,2.7,7e6]; # R + Emax + m1 + m2 + Δτ
        # this.pdev = [2e4,1e-12,1e-12,1e-12,1e-12,1e-12,0.1,2.7,7e6]; # Zc + Emax + m1 + m2
        # this.pdev = [2e4,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # Zc + Emax
        # this.pdev = [1e-12,2e6,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # R + Emax
        # this.pdev = [1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,0.1,1e-12,7e6]; # Emax + m1
        # this.pdev = [1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,2.7,7e6]; # Emax + m2
        this.pdev = [1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,1e-12,7e6]; # Emax
        this.lb = -Inf*ones(nparams);
        this.ub = Inf*ones(nparams);
        this.lb[1] = 1e1; # Zc
        this.lb[2] = 1e5; # R
        this.lb[3] = 1e-10; # C
        this.lb[5] = 0.01; # τ1
        this.lb[6] = 0.01; # Δτ
        this.lb[7] = 1.; # m1
        this.lb[8] = 1; # m2
        this.lb[9] = 1e6; # Emax
        this.ub[5] = 0.4; # τ1
        this.ub[6] = 0.55; # Δτ
        this.ub[9] = 2e8; # Emax
        return this
    end
end