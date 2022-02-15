## Code for JuliaPlanners repository ##

"Repository provided by the JuliaPlanners organization."
struct JuliaPlannersRepo <: PlanningRepository end

const JULIA_PLANNERS_DIR =
    normpath(dirname(pathof(@__MODULE__)), "..", "repositories", "julia-planners")

function load_domain(repo::JuliaPlannersRepo, domain::AbstractString)
    domain_dir = joinpath(JULIA_PLANNERS_DIR, domain)
    return load_domain(joinpath(domain_dir, "domain.pddl"))
end

function load_problem(repo::JuliaPlannersRepo,
                      domain::AbstractString, problem::AbstractString)
    domain_dir = joinpath(JULIA_PLANNERS_DIR, domain)
    return load_problem(joinpath(domain_dir, "$problem.pddl"))
end

function load_problem(repo::JuliaPlannersRepo, domain::AbstractString, idx::Int)
    return load_problem(repo, domain, "problem-$idx")
end

function list_domains(repo::JuliaPlannersRepo)
    return readdir(JULIA_PLANNERS_DIR)
end

function list_problems(repo::JuliaPlannersRepo, domain::AbstractString)
    # Filter out non-problem files
    fns = filter(readdir(joinpath(JULIA_PLANNERS_DIR, domain))) do fn
        match(r".*\.pddl", fn) !== nothing && fn != "domain.pddl"
    end
    # Strip .pddl suffix
    return map(fn -> fn[1:end-5], fns)
end
