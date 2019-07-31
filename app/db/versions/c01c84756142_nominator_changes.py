"""Nominator changes

Revision ID: c01c84756142
Revises: 195a4677ffd5
Create Date: 2019-07-31 11:28:37.264737

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'c01c84756142'
down_revision = '195a4677ffd5'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('data_session_nominator',
    sa.Column('session_id', sa.Integer(), autoincrement=False, nullable=False),
    sa.Column('rank_validator', sa.Integer(), autoincrement=False, nullable=False),
    sa.Column('rank_nominator', sa.Integer(), autoincrement=False, nullable=False),
    sa.Column('nominator_stash', sa.String(length=64), nullable=True),
    sa.Column('nominator_controller', sa.String(length=64), nullable=True),
    sa.Column('bonded', sa.Numeric(precision=65, scale=0), nullable=False),
    sa.PrimaryKeyConstraint('session_id', 'rank_validator', 'rank_nominator')
    )
    op.create_index(op.f('ix_data_session_nominator_nominator_controller'), 'data_session_nominator', ['nominator_controller'], unique=False)
    op.create_index(op.f('ix_data_session_nominator_nominator_stash'), 'data_session_nominator', ['nominator_stash'], unique=False)
    op.create_index(op.f('ix_data_session_nominator_rank_nominator'), 'data_session_nominator', ['rank_nominator'], unique=False)
    op.create_index(op.f('ix_data_session_nominator_rank_validator'), 'data_session_nominator', ['rank_validator'], unique=False)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_data_session_nominator_rank_validator'), table_name='data_session_nominator')
    op.drop_index(op.f('ix_data_session_nominator_rank_nominator'), table_name='data_session_nominator')
    op.drop_index(op.f('ix_data_session_nominator_nominator_stash'), table_name='data_session_nominator')
    op.drop_index(op.f('ix_data_session_nominator_nominator_controller'), table_name='data_session_nominator')
    op.drop_table('data_session_nominator')
    # ### end Alembic commands ###