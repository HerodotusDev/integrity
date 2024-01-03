use std::{
    fmt::Display,
    ops::{Deref, DerefMut},
};

#[derive(Debug, Clone)]
pub enum Expr {
    Value(String),
    Array(Vec<Expr>),
}

impl Display for Expr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Expr::Value(v) => write!(f, "\"{v}\""),
            Expr::Array(v) => {
                write!(f, "[")?;

                for (i, expr) in v.iter().enumerate() {
                    if i != 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{expr}")?;
                }

                write!(f, "]")?;

                Ok(())
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct Exprs(pub Vec<Expr>);

impl Display for Exprs {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "[")?;

        for (i, expr) in self.iter().enumerate() {
            if i != 0 {
                write!(f, ", ")?;
            }
            write!(f, "{expr}")?;
        }

        write!(f, "]")?;

        Ok(())
    }
}

impl Deref for Exprs {
    type Target = Vec<Expr>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for Exprs {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}
