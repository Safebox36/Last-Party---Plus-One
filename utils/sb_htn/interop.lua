require("utils.sb_htn.Utils.TableExt")

return {
    Conditions = {
        ICondition = require("utils.sb_htn.Conditions.ICondition"),
        FuncCondition = require("utils.sb_htn.Conditions.FuncCondition")
    },

    Contexts = {
        IContext = require("utils.sb_htn.Contexts.IContext"),
        BaseContext = require("utils.sb_htn.Contexts.BaseContext"),
    },

    Effects = {
        IEffect = require("utils.sb_htn.Effects.IEffect"),
        EEffectType = require("utils.sb_htn.Effects.EEffectType"),
        ActionEffect = require("utils.sb_htn.Effects.ActionEffect"),
    },

    Factory = {
        IFactory = require("utils.sb_htn.Factory.IFactory"),
        DefaultFactory = require("utils.sb_htn.Factory.DefaultFactory"),
    },

    Operators = {
        IOperator = require("utils.sb_htn.Operators.IOperator"),
        FuncOperator = require("utils.sb_htn.Operators.FuncOperator"),
    },

    Planners = {
        Planner = require("utils.sb_htn.Planners.Planner"),
    },

    Tasks = {
        ITask = require("utils.sb_htn.Tasks.ITask"),
        ETaskStatus = require("utils.sb_htn.Tasks.ETaskStatus"),

        CompoundTasks = {
            ICompoundTask = require("utils.sb_htn.Tasks.CompoundTasks.ICompoundTask"),
            IDecomposeAll = require("utils.sb_htn.Tasks.CompoundTasks.IDecomposeAll"),
            EDecompositionStatus = require("utils.sb_htn.Tasks.CompoundTasks.EDecompositionStatus"),
            CompoundTask = require("utils.sb_htn.Tasks.CompoundTasks.CompoundTask"),
            PausePlanTask = require("utils.sb_htn.Tasks.CompoundTasks.PausePlanTask"),
            Selector = require("utils.sb_htn.Tasks.CompoundTasks.Selector"),
            Sequence = require("utils.sb_htn.Tasks.CompoundTasks.Sequence"),
            TaskRoot = require("utils.sb_htn.Tasks.CompoundTasks.TaskRoot"),
        },

        OtherTasks = {
            Slot = require("utils.sb_htn.Tasks.OtherTasks.Slot"),
        },

        PrimitiveTasks = {
            IPrimitiveTask = require("utils.sb_htn.Tasks.PrimitiveTasks.IPrimitiveTask"),
            PrimitiveTask = require("utils.sb_htn.Tasks.PrimitiveTasks.PrimitiveTask")
        }
    },

    IDomain = require("utils.sb_htn.IDomain"),
    BaseDomainBuilder = require("utils.sb_htn.BaseDomainBuilder"),
    Domain = require("utils.sb_htn.Domain"),
    DomainBuilder = require("utils.sb_htn.DomainBuilder")
}
